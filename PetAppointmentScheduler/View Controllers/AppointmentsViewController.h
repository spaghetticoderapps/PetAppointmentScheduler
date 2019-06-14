//
//  ViewController.h
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/8/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentList.h"

@interface AppointmentsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray<AppointmentList *> *appointmentLists;

@end

