//
//  AppointmentSerializer.h
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/8/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Appointment.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentSerializer : NSObject

+ (NSMutableArray *) serializeAppointmentsFromJSON: (NSMutableDictionary *) json;

@end

NS_ASSUME_NONNULL_END
