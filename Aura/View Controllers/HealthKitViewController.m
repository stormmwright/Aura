//
//  HealthKitViewController.m
//  Aura
//
//  Created by Storm Wright on 7/30/21.
//

#import "HealthKitViewController.h"
#import "HealthKitManager.h"

@interface HealthKitViewController ()

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *pushesLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *sleepTimeLabel;


@end

@implementation HealthKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[HealthKitManager sharedManager]requestAuth];
    
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 4;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *identifier = @"";
//
//    if (indexPath.row == 0) {
//        identifier = @"StepsCell";
//    } else if (indexPath.row == 1) {
//        identifier = @"PushesCell";
//    } else if (indexPath.row == 2) {
//        identifier = @"WeightCell";
//    } else {
//        identifier = @"SleepCell";
//    }
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//
//    return cell;
//}

- (IBAction)readSteps:(id)sender {
    [[HealthKitManager sharedManager] getStepCountWithCompletion:^(double value, NSError *error) {
        NSLog(@"%f", value);
        if (value) {
            NSNumber *stepCount = [NSNumber numberWithDouble:value];
            
            self.stepsLabel.text = [stepCount stringValue];
            NSLog(@"%@", stepCount);
        }
    }];
}

// TODO: update label with pushes
- (IBAction)readPushes:(id)sender {
    [[HealthKitManager sharedManager] getPushCountWithCompletion:^(double value, NSError *error) {
        NSLog(@"%f", value);
        if (value) {
            NSNumber *pushCount = [NSNumber numberWithDouble:value];
            
            self.pushesLabel.text = [pushCount stringValue];
            NSLog(@"%@", pushCount);
        }
    }];
}

// TODO: update label with weight
- (IBAction)readWeight:(id)sender {
    [[HealthKitManager sharedManager] getWeight];
}

// TODO: update label with sleep time
- (IBAction)readSleepTime:(id)sender {
    [[HealthKitManager sharedManager] getSleepTime];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
