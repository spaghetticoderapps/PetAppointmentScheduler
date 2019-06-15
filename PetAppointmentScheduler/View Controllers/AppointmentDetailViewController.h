//
//  AppointmentDetailViewController.h
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/13/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentList.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppointmentDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *animalInfoLabel;

@property (strong, nonatomic) NSMutableArray<AppointmentList *> *appointmentLists;
@property (strong, nonatomic) Appointment *appointment;
+ (NSString *) segueIdentifier;

@end

NS_ASSUME_NONNULL_END
