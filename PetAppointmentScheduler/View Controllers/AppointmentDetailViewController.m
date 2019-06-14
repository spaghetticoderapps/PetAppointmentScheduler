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

@interface AppointmentDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *declineButton;
@property (weak, nonatomic) IBOutlet UIButton *rescheduleButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;

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
    _animalInfoLabel.text = [NSString stringWithFormat:@"%@ (%@)", _appointment.animal.species, _appointment.animal.breed];
    _userLabel.text = [NSString stringWithFormat:@"Requested by %@ %@ on %@", _appointment.user.firstName, _appointment.user.lastName, [_appointment.creationDate formattedDay]];
}

// MARK: - Actions

- (IBAction)decline:(id)sender {
    [self selectButton:_declineButton];
    _appointment.status = AppointmentStatusDeclined;
}

- (IBAction)reschedule:(id)sender {
    [self selectButton:_rescheduleButton];
}

- (IBAction)accept:(id)sender {
    [self selectButton:_acceptButton];
    _appointment.status = AppointmentStatusAccepted;
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



@end
