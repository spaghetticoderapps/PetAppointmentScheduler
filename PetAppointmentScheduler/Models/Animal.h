//
//  Animal.h
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/8/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Animal : NSObject

@property (nonatomic) int ID;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *species;
@property (strong, nonatomic) NSString *breed;

@end

NS_ASSUME_NONNULL_END
