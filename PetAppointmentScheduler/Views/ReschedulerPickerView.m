//
//  ReschedulerPickerView.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/16/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReschedulerPickerView.h"
#import "NSDate+Utilities.h"

@implementation ReschedulerPickerView

- (instancetype) initWithAppointment:(Appointment *) appointment
                              dates:(NSMutableArray<NSDate *> *) dates
{
    self = [super init];
    if (self) {
        _appointment = appointment;
        _dates = dates;
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}


// MARK: - UIPickerView Data Source

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _dates.count;
}

// MARK: - UIPickerView Delegate

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_dates[row] shortFormattedTime];
}


@end
