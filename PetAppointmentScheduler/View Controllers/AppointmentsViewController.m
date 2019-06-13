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

@interface AppointmentsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSMutableArray<AppointmentList *> *appointmentLists;
@property (strong, nonatomic) Appointment *selectedAppointment;

@end

@implementation AppointmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Appointments";
    [APIClient getAppointmentLists:^(NSMutableArray * _Nonnull appointmentLists) {
        __weak typeof(self) weakSelf = self;
        weakSelf.appointmentLists = appointmentLists;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.activityIndicator stopAnimating];
            [weakSelf.tableView reloadData];
        });
        
    }];
    
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
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _appointmentLists[section].appointments.count;
}


// MARK: - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

// MARK: - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:[AppointmentDetailViewController segueIdentifier]])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        _selectedAppointment = _appointmentLists[indexPath.section].appointments[indexPath.row];
        AppointmentDetailViewController *appointmentDetailViewController = [segue destinationViewController];
        appointmentDetailViewController.appointment = _selectedAppointment;
    }
}

@end
