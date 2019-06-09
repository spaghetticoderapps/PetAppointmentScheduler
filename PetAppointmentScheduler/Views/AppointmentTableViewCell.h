//
//  AppointmentTableViewCell.h
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/8/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *animalFirstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *breedLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

+ (NSString *) identifier;

@end

NS_ASSUME_NONNULL_END
