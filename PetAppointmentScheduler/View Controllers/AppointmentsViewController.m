//
//  ViewController.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/8/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "AppointmentsViewController.h"
#import "APIClient.h"
#import "AppointmentTableViewCell.h"
#import "NSDate+Utilities.h"
#import "AppointmentDetailViewController.h"
#import "NSMutableArray+Appointment.h"
#import "NSMutableArray+AppointmentList.h"
#import "UIColor+Style.h"
#import "NSMutableArray+AppointmentList.h"
#import "UIViewController+Utilities.h"

@interface AppointmentsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) Appointment *selectedAppointment;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation AppointmentsViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_appointmentLists) {
        [APIClient getAppointmentLists:^(NSMutableArray * _Nonnull appointmentLists) {
            __weak typeof(self) weakSelf = self;
            weakSelf.appointmentLists = appointmentLists;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.activityIndicator stopAnimating];
                [weakSelf.tableView reloadData];
            });
            
        }];
    } else {
        _appointmentLists = [_appointmentLists sort];
        [_tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Appt. Requests";
    
    _refreshControl = [UIRefreshControl new];
    [_refreshControl setAttributedTitle: [[NSAttributedString new] initWithString:@"Saving appointments..."]];
    [_refreshControl addTarget:self action:@selector(saveAppointmentDecisions) forControlEvents:UIControlEventValueChanged];
    [_tableView setRefreshControl:_refreshControl];
}

// MARK: - Table View Data Source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_appointmentLists[section].date formattedDay];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _appointmentLists.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    AppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AppointmentTableViewCell identifier]];
    
    Appointment *appointment = _appointmentLists[indexPath.section].appointments[indexPath.row];
    cell.typeLabel.text =  appointment.type;
    cell.animalLabel.text = [NSString stringWithFormat:@"%@ (%@)",appointment.animal.firstName, appointment.animal.breed ];
    cell.timeLabel.text = [appointment.requestedDate formattedTime];
    cell.statusLabel.text = [appointment formattedStatus];
    
    if (_selectedIndexPath == indexPath) {
        _selectedIndexPath = nil;
        // Animate status label
        [cell.statusLabel setAlpha:0];
        [cell.statusLabel setTransform:CGAffineTransformMakeScale(0, 0)];
        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [cell.statusLabel setAlpha:1];
            [cell.statusLabel setTransform:CGAffineTransformMakeScale(1.3, 1.3)];
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.5 animations:^{
                [cell.statusLabel setTransform:CGAffineTransformMakeScale(1.0, 1.)];
            }];
        }];
        
        // Animate background color
        NSTimeInterval animationDuration = 0.8;
        [UIView animateWithDuration:animationDuration/2 animations:^{
            [cell setBackgroundColor:[UIColor lightYellowColor]];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:animationDuration/2 animations:^{
                [cell setBackgroundColor:[UIColor whiteColor]];
            }];
        }];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _appointmentLists[section].appointments.count;
}


// MARK: - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndexPath = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 25;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    Appointment *appointment = self->_appointmentLists[indexPath.section].appointments[indexPath.row];
    
    UIContextualAction *rescheduleAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Reschedule" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self->_appointmentLists rescheduleAppointment:appointment];
        [self alertWithMessage:[NSString stringWithFormat:@"\nAppointment accepted and rescheduled to %@.\n", [appointment.requestedDate formattedTime]]];
        appointment.status = AppointmentStatusAccepted;
        self->_selectedIndexPath = indexPath;
        self->_appointmentLists = [self->_appointmentLists sort];
        [tableView reloadData];
        completionHandler(YES);
        
    }];
    [rescheduleAction setBackgroundColor:[UIColor lightBlueColor]];
    return [UISwipeActionsConfiguration configurationWithActions:@[rescheduleAction]];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Appointment *appointment = self->_appointmentLists[indexPath.section].appointments[indexPath.row];
    
    UIContextualAction *declineAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Decline" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        appointment.status = AppointmentStatusDeclined;
        self->_selectedIndexPath = indexPath;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        completionHandler(YES);
    }];
    
    [declineAction setBackgroundColor:[UIColor redColor]];
    
    UIContextualAction *acceptAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Accept" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        appointment.status = AppointmentStatusAccepted;
        self->_selectedIndexPath = indexPath;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        completionHandler(YES);
    }];
    
    [acceptAction setBackgroundColor:[UIColor darkGreenColor]];
    
    return [UISwipeActionsConfiguration configurationWithActions:@[acceptAction, declineAction]];
}

// MARK: - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:[AppointmentDetailViewController segueIdentifier]])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        _selectedAppointment = _appointmentLists[indexPath.section].appointments[indexPath.row];
        AppointmentDetailViewController *appointmentDetailViewController = [segue destinationViewController];
        appointmentDetailViewController.appointment = _selectedAppointment;
        appointmentDetailViewController.appointmentLists = _appointmentLists;
    }
}


// MARK: - Private Functions

- (void) saveAppointmentDecisions {
    [_appointmentLists removeProcessedAppointments:^(NSMutableArray * _Nonnull appointmentLists) {
        self->_appointmentLists = appointmentLists;
        [self->_tableView reloadData];
        [self->_refreshControl endRefreshing];
    }];
}


@end
