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

@interface AppointmentDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *declineButton;
@property (weak, nonatomic) IBOutlet UIButton *rescheduleButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (strong, nonatomic) UIDatePicker *picker;
@property (strong, nonatomic) UIToolbar *toolbar;
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
    [self showDatePicker];
//    [_appointmentLists rescheduleAppointment:_appointment];
//    [self alertWithMessage:[NSString stringWithFormat:@"\nAppointment accepted and rescheduled to %@.\n", [_appointment.requestedDate formattedTime]]];
    [self selectButton:_rescheduleButton];
    
    _appointment.status = AppointmentStatusAccepted;
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


- (IBAction)showDatePicker {
    _picker = [[UIDatePicker alloc] init];
    _picker.backgroundColor = [UIColor whiteColor];
    [_picker setValue:[UIColor blackColor] forKey:@"textColor"];
    
    _picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _picker.datePickerMode = UIDatePickerModeDateAndTime;
    _picker.minimumDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:1];
    
    NSDate *maximumDate = [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
    _picker.maximumDate = maximumDate;
    [_picker addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
    _picker.frame = CGRectMake(0.0, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width, 300);
    [self.view addSubview:_picker];
    
    _toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width, 50)];
    _toolbar.barStyle = UIBarStyleDefault;
    _toolbar.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDoneButtonClick)]];
    [_toolbar sizeToFit];
    [self.view addSubview:_toolbar];
}

-(void) dueDateChanged:(UIDatePicker *)sender {
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSLog(@"Picked the date %@", [dateFormatter stringFromDate:[sender date]]);
//    YOUR_LABEL.TEXT = [dateFormatter stringFromDate:[sender date]];
}

-(void)onDoneButtonClick {
    [_toolbar removeFromSuperview];
    [_picker removeFromSuperview];
}

@end
