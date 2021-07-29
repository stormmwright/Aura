//
//  ProfileViewController.m
//  Aura
//
//  Created by Storm Wright on 7/28/21.
//

#import "ProfileViewController.h"
#import "HealthKitManager.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[HealthKitManager sharedManager] requestAuth];
    [[HealthKitManager sharedManager] findCorrelation];
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
