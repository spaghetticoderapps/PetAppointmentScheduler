//
//  NSMutableArray+Appointment.h
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/14/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "AppointmentList.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (Appointment)

- (NSMutableArray<AppointmentList *> *) sortedAppointmentList;

@end

NS_ASSUME_NONNULL_END
