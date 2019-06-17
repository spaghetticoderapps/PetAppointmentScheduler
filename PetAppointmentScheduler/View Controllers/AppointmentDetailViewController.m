//
//  AppointmentDetailViewController.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/13/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "AppointmentDetailViewController.h"
#import "NSDate+Utilities.h"
#import "UIButton+Utilities.h"
#import "NSMutableArray+AppointmentList.h"
#import "UIViewController+Utilities.h"
#import "NSDate+Utilities.h"
#import "ReschedulerPickerView.h"
#import "UIColor+Style.h"

@interface AppointmentDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *declineButton;
@property (weak, nonatomic) IBOutlet UIButton *rescheduleButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (strong, nonatomic) ReschedulerPickerView *reschedulerPickerView;
@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) NSMutableArray<NSDate *> *dates;
@end

@implementation AppointmentDetailViewController

+ (NSString *)segueIdentifier {
    return @"appointmentDetail";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_declineButton roundCorners];
    [_rescheduleButton roundCorners];
    [_acceptButton roundCorners];
    
    [self preselectButton];
    
    self.title = [NSString stringWithFormat:@"%@", [_appointment.requestedDate formattedTime]];
    _dateLabel.text = [_appointment.requestedDate formattedDay];
    _typeLabel.text = [NSString stringWithFormat: @"%@ for %@", _appointment.type, _appointment.animal.firstName];
    _animalInfoLabel.text = [NSString stringWithFormat:@"Species: %@\nBreed: %@", _appointment.animal.species, _appointment.animal.breed];
    _userLabel.text = [NSString stringWithFormat:@"Requested by %@ %@ on %@", _appointment.user.firstName, _appointment.user.lastName, [_appointment.creationDate formattedDay]];
}

// MARK: - Actions

- (IBAction)decline:(id)sender {
    [self selectButton:_declineButton];
    if (_appointment.status != AppointmentStatusDeclined) {
        _appointment.status = AppointmentStatusDeclined;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)reschedule:(id)sender {
    [self showReschedulerPickerView];
}

- (IBAction)accept:(id)sender {
    [self selectButton:_acceptButton];
    if (_appointment.status != AppointmentStatusAccepted) {
        _appointment.status = AppointmentStatusAccepted;
        [self.navigationController popViewControllerAnimated:YES];
    }
}


// MARK: - Private Fucntions

- (void) preselectButton {
    switch (_appointment.status) {
        case AppointmentStatusDeclined:
            [self selectButton:_declineButton];
            break;
        case AppointmentStatusAccepted:
            [self selectButton:_acceptButton];
            break;
        default:
            break;
    }
}

- (void) selectButton: (UIButton *) selectedButton {
    NSArray *buttons = @[_declineButton, _rescheduleButton, _acceptButton];
    
    for (UIButton *button in buttons) {
        [button setBackgroundColor:[UIColor clearColor]];
        [button removeBorder];
    }
    
    [selectedButton setBackgroundColor:[UIColor whiteColor]];
    [selectedButton addBorder];
}

- (void) showReschedulerPickerView {
    _dates = [_appointmentLists availableDatesInUpcomingMonthBasedOffDate:_appointment.requestedDate];
    _reschedulerPickerView = [[ReschedulerPickerView alloc] initWithAppointment:_appointment dates: _dates];
    [_reschedulerPickerView setBackgroundColor:[UIColor paleLightBlueColor]];
    
    [[self view] addSubview:_reschedulerPickerView];
    [_reschedulerPickerView becomeFirstResponder];
    
    [_reschedulerPickerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[_reschedulerPickerView.heightAnchor constraintEqualToConstant:300] setActive:YES];
    [[_reschedulerPickerView.bottomAnchor constraintEqualToAnchor:[self view].bottomAnchor] setActive:YES];
    [[_reschedulerPickerView.leadingAnchor constraintEqualToAnchor:[self view].leadingAnchor] setActive:YES];
    [[_reschedulerPickerView.trailingAnchor constraintEqualToAnchor:[self view].trailingAnchor] setActive:YES];
    
    _toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width, 200)];
    _toolbar.barStyle = UIBarStyleDefault;
    UIBarButtonItem *flexibleSpaceBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    _toolbar.items = @[
                       [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(removeReschedulerPickerView)],
                       flexibleSpaceBtn,
                       flexibleSpaceBtn,
                       [[UIBarButtonItem alloc]initWithTitle:@"Reschedule" style:UIBarButtonItemStyleDone target:self action:@selector(manuallyRescheduleAppointment)]
                       ];
    [_toolbar sizeToFit];
    [self.view addSubview:_toolbar];
}


// MARK: - Selectors

- (void) manuallyRescheduleAppointment {
    NSInteger selectedRow = [_reschedulerPickerView selectedRowInComponent:0];
    _appointment.requestedDate = _dates[selectedRow];
    _appointment.status = AppointmentStatusAccepted;
    [self removeReschedulerPickerView];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) removeReschedulerPickerView {
    [_toolbar removeFromSuperview];
    [_reschedulerPickerView removeFromSuperview];
}

@end
