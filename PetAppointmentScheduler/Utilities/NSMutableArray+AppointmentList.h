//
//  NSMutableArray+AppointmentList.h
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/14/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "AppointmentList.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (AppointmentList)

- (void) rescheduleAppointment: (Appointment *) appointment;
- (NSMutableArray<AppointmentList *> *) sort;
- (NSMutableArray<NSDate *> *) availableDatesInUpcomingMonthBasedOffDate: (NSDate *) date;
- (void) removeProcessedAppointments: (void (^) (NSMutableArray *appointmentLists)) completionBlock;
@end

NS_ASSUME_NONNULL_END
