//
//  ViewController.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/8/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "AppointmentsViewController.h"
#import "APIClient.h"
#import "AppointmentTableViewCell.h"
#import "NSDate+Utilities.h"

@interface AppointmentsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<AppointmentList *> *appointmentLists;

@end

@implementation AppointmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Appointments";
    
    [APIClient getAppointmentLists:^(NSMutableArray * _Nonnull appointmentLists) {
        __weak typeof(self) weakSelf = self;
        weakSelf.appointmentLists = appointmentLists;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        
    }];
    
}

// MARK: - Table View Data Source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_appointmentLists[section].date formattedTime];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _appointmentLists.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    AppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AppointmentTableViewCell identifier]];
    
    Appointment *appointment = _appointmentLists[indexPath.section].appointments[indexPath.row];
    cell.animalFirstNameLabel.text = appointment.animal.firstName;
    cell.breedLabel.text = appointment.animal.breed;
    cell.typeLabel.text =  appointment.type;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _appointmentLists[section].appointments.count;
}


// MARK: - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


@end
