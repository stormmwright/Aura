//
//  ProfileViewController.m
//  Aura
//
//  Created by Storm Wright on 7/28/21.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)getResources {
    // *if* >= *1/3 of 7 (2)* week entries are mild (good, very good, best), moderate (neutral), or severe (bad, very bad, worst), *then* present 1-3 of static _resources_ based on their entry stats
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
