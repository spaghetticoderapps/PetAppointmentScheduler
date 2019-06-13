//
//  AppointmentDetailViewController.h
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/13/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppointmentDetailViewController : UIViewController

@property (strong, nonatomic) Appointment *appointment;
+ (NSString *) segueIdentifier;

@end

NS_ASSUME_NONNULL_END
