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

- (NSString *)shortFormattedTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E, MMM d, yyyy";
    NSString *date = [formatter stringFromDate:self];
    formatter.dateFormat = @"h:mm a";
    NSString *time = [formatter stringFromDate:self];
    return [NSString stringWithFormat:@"%@ - %@", date, time];
}

- (NSDate *)addOneHour {
    return [self dateByAddingTimeInterval:3600];
}

- (NSString *)utcString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    return [formatter stringFromDate:self];
}

- (BOOL)isDuringOfficeHours {
    NSDateComponents *openingTime = [[NSDateComponents alloc] init];
    openingTime.hour = 8;
    openingTime.minute = 0;
    
    NSDateComponents *closingTime = [[NSDateComponents alloc] init];
    closingTime.hour = 17;
    closingTime.minute = 0;
    
    NSDate *requestedAppointmentTime = [NSDate new];
    requestedAppointmentTime = self;
    
    NSDateComponents *requestedAppointmentTimeComponenents = [[NSCalendar currentCalendar] components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond
                                                                    fromDate:requestedAppointmentTime];
    
    NSMutableArray *times = [@[openingTime, closingTime, requestedAppointmentTimeComponenents] mutableCopy];
    [times sortUsingComparator:^NSComparisonResult(NSDateComponents *t1, NSDateComponents *t2) {
        if (t1.hour > t2.hour) {
            return NSOrderedDescending;
        }
        
        if (t1.hour < t2.hour) {
            return NSOrderedAscending;
        }
        // hour is the same
        if (t1.minute > t2.minute) {
            return NSOrderedDescending;
        }
        
        if (t1.minute < t2.minute) {
            return NSOrderedAscending;
        }
        // hour and minute are the same
        if (t1.second > t2.second) {
            return NSOrderedDescending;
        }
        
        if (t1.second < t2.second) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
        
    }];
    
    return [times indexOfObject:requestedAppointmentTimeComponenents] == 1;
}

- (NSDate *)roundedToNextHour {
    NSDate *roundedDate = [NSDate new];
    NSTimeInterval ceilingTimeInterval = ceil([self timeIntervalSinceReferenceDate] / 3600.0) * 3600;
    
    roundedDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:ceilingTimeInterval];
    return roundedDate;
}
@end
