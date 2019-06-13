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

+ (NSMutableArray *)serializeAppointmentsFromJSON:(NSMutableDictionary *)json {
    NSMutableArray *array = [NSMutableArray new];
    for(NSMutableDictionary *object in json) {

        Appointment *appointment = [Appointment new];
        appointment.ID = [object[@"appointmentId"] intValue];
        appointment.type = object[@"appointmentType"];
        appointment.creationDate = [[object[@"createDateTime"] convertToDate] localTime];
        appointment.requestedDate = [[object[@"requestedDateTimeOffset"] convertOffsetToDate] localTime];
        
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

-(NSMutableArray *) sortedAppointments: (NSMutableArray*) array {
    
    return array;
}

+ (NSMutableArray<AppointmentList *> *)appointmentListsFromAppointments:(NSMutableArray<Appointment *> *)appointments {
    NSMutableArray<AppointmentList *> *appointmentLists = [NSMutableArray<AppointmentList *> new];
    AppointmentList *initialAppointmentList = [AppointmentList new];
    initialAppointmentList.appointments = [NSMutableArray<Appointment *> new];
    [appointmentLists addObject:initialAppointmentList];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"requestedDate" ascending:TRUE];
    [appointments sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    // Create appointment list objects through sorting
    for (int i=0; i <= appointments.count-1; i++) {
        if (i==0) {
            [appointmentLists lastObject].date = appointments[i].requestedDate;
            [[appointmentLists lastObject].appointments addObject:appointments[i]];
            continue;
        }
        
        NSDate *appointmentDate = appointments[i].requestedDate;
        NSDate *previousDate = appointments[i-1].requestedDate;
        if ([[NSCalendar currentCalendar] isDate:appointmentDate inSameDayAsDate:previousDate]) {
            [[appointmentLists lastObject].appointments addObject:appointments[i]];
        } else {
            AppointmentList *appointmentList = [AppointmentList new];
            [appointmentLists addObject:appointmentList];
            [appointmentLists lastObject].date = appointments[i].requestedDate;
            appointmentList.appointments = [NSMutableArray<Appointment *> new];
            [[appointmentLists lastObject].appointments addObject:appointments[i]];
        }
        
    }
    
    
    return appointmentLists;
}

@end

