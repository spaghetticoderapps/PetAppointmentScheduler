//
//  UIViewController+Utilities.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/14/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "UIViewController+Utilities.h"

@implementation UIViewController (Utilities)

- (void) alertWithMessage:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController
                                 alertControllerWithTitle:@"Appointment Rescheduled"
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAlertAction = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self.navigationController popViewControllerAnimated:YES];
                                }];
    
    [alertController addAction:okAlertAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)alertWithError:(NSError *)error {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Network request error"
                                          message:error.localizedDescription
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAlertAction = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:nil];
    
    [alertController addAction:okAlertAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
