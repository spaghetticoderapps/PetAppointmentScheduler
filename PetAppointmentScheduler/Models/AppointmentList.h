//
//  AppointmentList.h
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/12/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Appointment.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentList : NSObject

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSMutableArray<Appointment *> *appointments;

@end

NS_ASSUME_NONNULL_END
