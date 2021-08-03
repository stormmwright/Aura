//
//  ProfileViewController.m
//  Aura
//
//  Created by Storm Wright on 7/28/21.
//

#import "ProfileViewController.h"
#import "Entry.h"
#import "HealthKitManager.h"

@interface ProfileViewController ()

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *mildView;
@property (weak, nonatomic) IBOutlet UITextView *moderateView;
@property (weak, nonatomic) IBOutlet UITextView *severeView;

@property (strong, nonatomic) NSMutableDictionary *mildModerateSevere;

@property (strong, nonatomic) NSArray *arrayOfEntries;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    
    [self fetchEntries];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 3;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *identifier = @"";
//    
//    if (indexPath.row == 0) {
//        identifier = @"MildCell";
//    } else if (indexPath.row == 1) {
//        identifier = @"ModerateCell";
//    } else {
//        identifier = @"SevereCell";
//    }
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    
//    return cell;
//}

- (void)fetchEntries {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Entry"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *entries, NSError *error) {
        if (entries != nil) {
            NSLog(@"%@", entries);
            self.arrayOfEntries = entries;
            [self getHealthStats];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)getMoodDictionary {
    NSMutableDictionary *resourceCategory = [NSMutableDictionary new];
    NSNumber *initNum = [NSNumber numberWithInt:0];
    
    self.mildModerateSevere = resourceCategory;
    [self.mildModerateSevere setObject:initNum forKey:@"Mild"];
    [self.mildModerateSevere setObject:initNum forKey:@"Moderate"];
    [self.mildModerateSevere setObject:initNum forKey:@"Severe"];

    for (int i = 0; i < self.arrayOfEntries.count; i++) {
            Entry *entry = self.arrayOfEntries[i];
        if ([entry.mood  isEqual: @"Good"] || [entry.mood isEqual: @"Very Good"] || [entry.mood isEqual: @"Best"] ) {
            int value = [self.mildModerateSevere[@"Mild"] intValue] + 1;
            NSNumber *newNum = [NSNumber numberWithInt:value];
            [self.mildModerateSevere setValue:newNum forKey:@"Mild"];
        } else if ([entry.mood  isEqual: @"Neutral"]) {
            int value = [self.mildModerateSevere[@"Moderate"] intValue] + 1;
            NSNumber *newNum = [NSNumber numberWithInt:value];
            [self.mildModerateSevere setValue:newNum forKey:@"Moderate"];
        } else {
            int value = [self.mildModerateSevere[@"Severe"] intValue] + 1;
            NSNumber *newNum = [NSNumber numberWithInt:value];
            [self.mildModerateSevere setValue:newNum forKey:@"Severe"];
        }
    }
}
    
// *if* >= *1/3 of 7 (2)* week entries are mild (good, very good, best), moderate (neutral), or severe (bad, very bad, worst), *then* present 1-3 of static _resources_ based on their entry stats
- (void)getResources {
    [self getMoodDictionary];
    
    // TODO: write static resources
    if ([self.mildModerateSevere[@"Mild"] intValue] >= 2) {
        self.mildView.text = @"[Insert Mild Resource]";
    } else if ([self.mildModerateSevere[@"Moderate"] intValue] >= 2) {
        self.moderateView.text = @"[Insert Moderate Resource]";
    } else if ([self.mildModerateSevere[@"Severe"] intValue] >= 2) {
        self.severeView.text = @"[Insert Severe Resource]";
    }
}

- (void)getHealthStats {
    [[HealthKitManager sharedManager] getStepCountWithCompletion:^(double value, NSError *error) {
        NSLog(@"%f", value);
        if (value && value <= 21000) {
            [self getResources];
        } else {
            NSLog(@"Null");
        }
    }];
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
