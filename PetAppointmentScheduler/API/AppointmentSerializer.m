//
//  AppointmentSerializer.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/8/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "AppointmentSerializer.h"
#import "NSDate+Utilities.h"
#import "NSString+Utilities.h"

@implementation AppointmentSerializer

+ (NSMutableArray *) serializeAppointmentsFromJSON:(NSMutableDictionary *)json {
    NSMutableArray *array = [NSMutableArray new];
    for(NSMutableDictionary *object in json) {

        Appointment *appointment = [Appointment new];
        appointment.ID = [object[@"appointmentId"] intValue];
        appointment.type = object[@"appointmentType"];
        appointment.creationDate = [[object[@"createDateTime"] convertToDate] localTime];
        appointment.requestedDate = [object[@"requestedDateTimeOffset"] convertOffsetToDate];
        
        NSDictionary *animalDictionary = object[@"animal"];
        Animal *animal = [Animal new];
        animal.ID = [animalDictionary[@"animalId"] intValue];
        animal.breed = [animalDictionary[@"breed"] isKindOfClass:[NSNull class]] ? @"N/A" : animalDictionary[@"breed"];
        animal.firstName = animalDictionary[@"firstName"];
        animal.species = [animalDictionary[@"species"] isKindOfClass:[NSNull class]] ? @"N/A" : animalDictionary[@"species"];
        
        appointment.animal = animal;
        
        NSDictionary *userDictionary = object[@"user"];
        User *user = [User new];
        user.firstName = userDictionary[@"firstName"];
        user.lastName = userDictionary[@"lastName"];
        user.ID = [userDictionary[@"userId"] intValue];
        
        appointment.user = user;
        
        [array addObject:appointment];
        
    }
    
    
    return array;
}


@end

