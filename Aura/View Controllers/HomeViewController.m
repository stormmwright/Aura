//
//  HomeViewController.m
//  Aura
//
//  Created by Storm Wright on 7/22/21.
//

#import "HomeViewController.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
