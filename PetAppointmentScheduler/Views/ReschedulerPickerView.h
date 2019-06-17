//
//  ReschedulerPickerView.h
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/16/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentList.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReschedulerPickerView : UIPickerView<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSMutableArray<NSDate *> *dates;
@property (strong, nonatomic) Appointment *appointment;

-(instancetype) initWithAppointment: (Appointment *) appointment dates: (NSMutableArray<NSDate*> *) dates;

@end

NS_ASSUME_NONNULL_END
