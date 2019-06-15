//
//  NSMutableArray+Appointment.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/14/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "NSMutableArray+Appointment.h"

@implementation NSMutableArray (Appointment)

- (NSMutableArray<AppointmentList *> *)sortedAppointmentList {
    
    NSMutableArray<Appointment *> *appointments = self;
    
    NSMutableArray<AppointmentList *> *appointmentLists = [NSMutableArray<AppointmentList *> new];
    AppointmentList *initialAppointmentList = [AppointmentList new];
    initialAppointmentList.appointments = [NSMutableArray<Appointment *> new];
    [appointmentLists addObject:initialAppointmentList];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"requestedDate" ascending:TRUE];
    [appointments sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    // Create appointment list objects via sorting
    for (int i=0; i <= appointments.count-1; i++) {
        if (i==0) {
            [appointmentLists lastObject].date = appointments[i].requestedDate;
            [[appointmentLists lastObject].appointments addObject:appointments[i]];
            continue;
        }
        
        NSDate *appointmentDate = appointments[i].requestedDate;
        NSDate *previousDate = appointments[i-1].requestedDate;
        if ([[NSCalendar currentCalendar] isDate:appointmentDate inSameDayAsDate:previousDate]) {
            [[appointmentLists lastObject].appointments addObject:appointments[i]];
        } else {
            AppointmentList *appointmentList = [AppointmentList new];
            [appointmentLists addObject:appointmentList];
            [appointmentLists lastObject].date = appointments[i].requestedDate;
            appointmentList.appointments = [NSMutableArray<Appointment *> new];
            [[appointmentLists lastObject].appointments addObject:appointments[i]];
        }
        
    }
    
    return appointmentLists;
    
}

@end
