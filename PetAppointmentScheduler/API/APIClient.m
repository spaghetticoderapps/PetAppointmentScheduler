//
//  APIClient.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/8/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "APIClient.h"


@implementation APIClient

+ (void)getAppointmentLists:(void (^)(NSMutableArray * _Nonnull))completionBlock {
    NSString *appointmentsURLString = @"https://sampledata.petdesk.com/api/Appointments";
    NSURL *url = [NSURL URLWithString:appointmentsURLString];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                              completionBlock([AppointmentSerializer appointmentListsFromAppointments:[AppointmentSerializer serializeAppointmentsFromJSON:json]]);
                                          }];
    
    [downloadTask resume];
}

@end
