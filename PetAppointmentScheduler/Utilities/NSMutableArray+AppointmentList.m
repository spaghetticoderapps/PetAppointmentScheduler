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

- (NSMutableArray<NSDate *> *)availableDatesInUpcomingMonthBasedOffDate:(NSDate *)date {
    NSMutableArray<NSDate *> *availableDates = [NSMutableArray<NSDate *> new];
    NSMutableDictionary *appointmentDates = [NSMutableDictionary new];
    
    for (AppointmentList *appointmentList in self) {
        for (Appointment *existingAppointment in appointmentList.appointments) {
            [appointmentDates setObject:@YES forKey:[existingAppointment.requestedDate utcString]];
        }
    }
    
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *oneMonthComponents = [[NSDateComponents alloc] init];
    [oneMonthComponents setMonth:1];
    
    NSDateComponents *oneHourComponents = [[NSDateComponents alloc] init];
    [oneHourComponents setHour:1];
    
    NSDate *endDate = [calendar dateByAddingComponents:oneMonthComponents toDate:[NSDate date] options:0];
    
    
    while ([currentDate compare:endDate] == NSOrderedAscending) {
        
        if (!appointmentDates[[currentDate utcString]] && [currentDate isDuringOfficeHours]) {
            [availableDates addObject:currentDate];
        }
        
        currentDate = [calendar dateByAddingComponents:oneHourComponents
                                                toDate:currentDate
                                               options:0];
    }
    
    
    return availableDates;
}

- (void)removeProcessedAppointments:(void (^)(NSMutableArray * _Nonnull))completionBlock {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSMutableArray<AppointmentList *> *appointmentLists = [NSMutableArray<AppointmentList *> new];
        
        for (int i = 0; i < self.count ; i++) {
            
            AppointmentList *appointmentList = self[i];
            AppointmentList *copiedAppointmentList = appointmentList;
            [appointmentLists addObject:copiedAppointmentList];
            
            for (int i=0; i < appointmentList.appointments.count; i++) {
                Appointment *existingAppointment = appointmentList.appointments[i];
                if (existingAppointment.status) {
                    
                    NSUInteger copiedAppointmentIndex = 0;
                    
                    for (Appointment *copiedAppointment in copiedAppointmentList.appointments) {
                        if (existingAppointment.ID == copiedAppointment.ID) {
                            copiedAppointmentIndex = [copiedAppointmentList.appointments indexOfObject:copiedAppointment];
                        }
                    }
                    
                    [copiedAppointmentList.appointments removeObjectAtIndex:copiedAppointmentIndex];
                    
                    
                    if (appointmentList.appointments.count == 0) {
                        [appointmentLists removeObject:appointmentList];
                        break;
                    }
                }
            }
        }
        completionBlock(appointmentLists);
    });
    
    
}


@end
