//
//  NSDate+Utilities.h
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/12/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Utilities)

-(NSDate *) localTime;
-(NSString *) formattedDay;
-(NSString *) formattedTime;
@end

NS_ASSUME_NONNULL_END
