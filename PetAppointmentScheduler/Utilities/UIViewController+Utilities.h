//
//  UIViewController+Utilities.h
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/14/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Utilities)

- (void) alertWithMessage: (NSString *) message;
- (void) alertWithError: (NSError *) error;

@end

NS_ASSUME_NONNULL_END
