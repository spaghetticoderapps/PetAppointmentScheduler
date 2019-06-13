//
//  NSDate+Utilities.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/12/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "NSDate+Utilities.h"

@implementation NSDate (Utilities)

-(NSDate *) localTime
{
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [timeZone secondsFromGMTForDate: self];
    return [NSDate dateWithTimeInterval: seconds sinceDate: self];
}

- (NSString *)formattedDay {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMMM dd, yyyy";
    return [formatter stringFromDate:self];
}

- (NSString *)formattedTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"hh:ss a";
    return [formatter stringFromDate:self];
}

@end
