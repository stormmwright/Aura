//
//  HomeViewController.m
//  Aura
//
//  Created by Storm Wright on 7/22/21.
//

#import "HomeViewController.h"
#import "Entry.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"";
    
    // create util function that takes in indexPath.row and returns identifier
    if (indexPath.row == 0) {
        identifier = @"BestCell";
    } else if (indexPath.row == 1) {
        identifier = @"VeryGoodCell";
    } else if (indexPath.row == 2) {
        identifier = @"GoodCell";
    } else if (indexPath.row == 3) {
        identifier = @"NeutralCell";
    } else if (indexPath.row == 4) {
        identifier = @"BadCell";
    } else if (indexPath.row == 5) {
        identifier = @"VeryBadCell";
    } else {
        identifier = @"WorstCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    return cell;
}

// ask about efficiency of seperate buttons and segues during office hours
- (IBAction)enterBest:(id)sender {
    NSString *mood = @"Best";
    
    [Entry logUserEntry:mood withCompletion:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Successfully logged entry");
        } else {
            NSLog(@"error %@", error);
        }
    }];
}

- (IBAction)enterVeryGood:(id)sender {
    NSString *mood = @"Very Good";
    
    [Entry logUserEntry:mood withCompletion:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Successfully logged entry");
        } else {
            NSLog(@"error %@", error);
        }
    }];
}

- (IBAction)enterGood:(id)sender {
    NSString *mood = @"Good";
    
    [Entry logUserEntry:mood withCompletion:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Successfully logged entry");
        } else {
            NSLog(@"error %@", error);
        }
    }];
}

- (IBAction)enterNeutral:(id)sender {
    NSString *mood = @"Neutral";
    
    [Entry logUserEntry:mood withCompletion:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Successfully logged entry");
        } else {
            NSLog(@"error %@", error);
        }
    }];
}

- (IBAction)enterBad:(id)sender {
    NSString *mood = @"Bad";
    
    [Entry logUserEntry:mood withCompletion:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Successfully logged entry");
        } else {
            NSLog(@"error %@", error);
        }
    }];
}

- (IBAction)enterVeryBad:(id)sender {
    NSString *mood = @"Very Bad";
    
    [Entry logUserEntry:mood withCompletion:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Successfully logged entry");
        } else {
            NSLog(@"error %@", error);
        }
    }];
}

- (IBAction)enterWorst:(id)sender {
    NSString *mood = @"Worst";
    
    [Entry logUserEntry:mood withCompletion:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Successfully logged entry");
        } else {
            NSLog(@"error %@", error);
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
