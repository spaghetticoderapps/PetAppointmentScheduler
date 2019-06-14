//
//  NSString+Utilities.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/12/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "NSString+Utilities.h"

@implementation NSString (Utilities)


- (NSDate *)convertToDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    return [formatter dateFromString:self];
}

- (NSDate *)convertOffsetToDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    return [formatter dateFromString:self];
}

@end
