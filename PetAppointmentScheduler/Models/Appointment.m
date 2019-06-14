//
//  Appointment.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/8/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "Appointment.h"

@implementation Appointment

- (NSString *)formattedStatus {
    switch (_status) {
        case AppointmentStatusDeclined:
            return @"👎";
            break;
        case AppointmentStatusAccepted:
            return @"👌";
            break;
        case AppointmentStatusUnknown:
            return @"👉";
            break;
    }
    return @"";
}

@end
