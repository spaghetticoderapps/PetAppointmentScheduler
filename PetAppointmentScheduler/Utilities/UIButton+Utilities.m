//
//  UIButton+Utilities.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/14/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "UIButton+Utilities.h"

@implementation UIButton (Utilities)

- (void) roundCorners {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
}

- (void)addBorder {
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 0.5;
}

- (void)removeBorder {
    self.layer.borderWidth = 0;
}

@end
