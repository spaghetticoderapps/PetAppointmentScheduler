//
//  APIClient.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/8/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "APIClient.h"
#import "NSMutableArray+Appointment.h"

@implementation APIClient

+ (void)getAppointmentLists:(void (^)(NSMutableArray *appointmentLists, NSError *error)) completionBlock {
    NSString *appointmentsURLString = @"https://sampledata.petdesk.com/api/Appointments";
    NSURL *url = [NSURL URLWithString:appointmentsURLString];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              
                                              if (error) {
                                                  completionBlock(nil, error);
                                              }
                                              
                                              NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                              completionBlock([[AppointmentSerializer serializeAppointmentsFromJSON:json] sortedAppointmentList], nil);
                                          }];
    
    [downloadTask resume];
}

@end
