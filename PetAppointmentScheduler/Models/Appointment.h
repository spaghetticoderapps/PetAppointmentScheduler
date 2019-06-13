//
//  Appointment.h
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/8/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Animal.h"

NS_ASSUME_NONNULL_BEGIN

@interface Appointment : NSObject

@property (nonatomic) int ID;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSDate *creationDate;
@property (strong, nonatomic) NSDate *requestedDate;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Animal *animal;

@end

NS_ASSUME_NONNULL_END
