//
//  ViewController.m
//  PetAppointmentScheduler
//
//  Created by Jeff Cedilla on 6/8/19.
//  Copyright © 2019 Jeff Cedilla. All rights reserved.
//

#import "AppointmentsViewController.h"
#import "APIClient.h"

@interface AppointmentsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<Appointment *> *appointments;

@end

@implementation AppointmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [APIClient getAppointments:^(NSMutableArray * _Nonnull appointments) {
        __weak typeof(self) weakSelf = self;
        weakSelf.appointments = appointments;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        
    }];
    
}


// MARK: - Table View Data Source

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Appointment *appointment = _appointments[indexPath.row];
    cell.textLabel.text =  appointment.type;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_appointments count];
}


@end
