//
//  NSMutableArray+AppointmentList.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/14/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "NSMutableArray+AppointmentList.h"
#import "NSMutableArray+Appointment.h"
#import "NSDate+Utilities.h"

@implementation NSMutableArray (AppointmentList)

- (void) rescheduleAppointment:(Appointment *) appointment {
    
    NSDate *possibleRescheduledDate = [appointment.requestedDate addOneHour];
    NSMutableDictionary *appointmentDates = [NSMutableDictionary new];
    
    for (AppointmentList *appointmentList in self) {
        for (Appointment *existingAppointment in appointmentList.appointments) {
            [appointmentDates setObject:@YES forKey:[existingAppointment.requestedDate utcString]];
        }
    }
    
    BOOL shouldKeepCheckingDates = YES;
    
    while (shouldKeepCheckingDates) {
        if ([appointmentDates valueForKey:[possibleRescheduledDate utcString]]) {
            possibleRescheduledDate = [possibleRescheduledDate addOneHour];
        } else {
            shouldKeepCheckingDates = NO;
        }
    }
    
    appointment.requestedDate = possibleRescheduledDate;
}

- (NSMutableArray<AppointmentList *> *) sort {
    NSMutableArray<Appointment *> *appointments = [NSMutableArray<Appointment *> new];
    
    for (AppointmentList *appointmentList in self) {
        for (Appointment *existingAppointment in appointmentList.appointments) {
            [appointments addObject:existingAppointment];
        }
    }
    
    return [appointments sortedAppointmentList];
}

@end
