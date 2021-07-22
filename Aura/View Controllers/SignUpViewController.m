//
//  SignUpViewController.m
//  Aura
//
//  Created by Storm Wright on 7/22/21.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)signUp:(id)sender {
    PFUser *newUser = [PFUser user];
    
    newUser.username = self.username.text;
    newUser.email = self.email.text;
    newUser.password = self.password.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            [self performSegueWithIdentifier:@"signUpSegue" sender:nil];
        }
    }];
}

- (IBAction)hideKeyboard:(id)sender {
    [self.username endEditing:true];
    [self.email endEditing:true];
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
