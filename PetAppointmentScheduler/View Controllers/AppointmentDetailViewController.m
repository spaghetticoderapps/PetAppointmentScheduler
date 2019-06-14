//
//  AppointmentDetailViewController.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/13/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "AppointmentDetailViewController.h"
#import "NSDate+Utilities.h"

@interface AppointmentDetailViewController ()

@end

@implementation AppointmentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@", [_appointment.requestedDate formattedTime]];
    _dateLabel.text = [_appointment.requestedDate formattedDay];
    _typeLabel.text = [NSString stringWithFormat: @"%@ for %@", _appointment.type, _appointment.animal.firstName];
    _animalInfoLabel.text = [NSString stringWithFormat:@"%@ (%@)", _appointment.animal.species, _appointment.animal.breed];
    _userLabel.text = [NSString stringWithFormat:@"Requested by %@ %@ on %@", _appointment.user.firstName, _appointment.user.lastName, [_appointment.creationDate formattedDay]];
}

+ (NSString *)segueIdentifier {
    return @"appointmentDetail";
}


// MARK: - Actions

- (IBAction)decline:(id)sender {
    _appointment.status = AppointmentStatusDeclined;
}

- (IBAction)reschedule:(id)sender {
    
}

- (IBAction)accept:(id)sender {
    _appointment.status = AppointmentStatusAccepted;
}


@end
