//
//  LogInViewController.m
//  Aura
//
//  Created by Storm Wright on 7/22/21.
//

#import "LogInViewController.h"
#import "Parse/Parse.h"

@interface LogInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)logIn:(id)sender {
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // display home view controller after successful login
            [self performSegueWithIdentifier:@"logInSegue" sender:nil];
        }
    }];
}

- (IBAction)hideKeyboard:(id)sender {
    [self.username endEditing:true];
    [self.password endEditing:true];
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
