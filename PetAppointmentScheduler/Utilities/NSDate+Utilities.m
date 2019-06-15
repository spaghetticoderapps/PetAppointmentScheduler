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
    formatter.dateFormat = @"EEEE, MMMM dd, yyyy";
    return [formatter stringFromDate:self];
}

- (NSString *)formattedTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"h:mm a";
    return [formatter stringFromDate:self];
}

- (NSDate *)addOneHour {
    return [self dateByAddingTimeInterval:3600];
}

- (NSString *)utcString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    return [formatter stringFromDate:self];
}

@end
