//
//  LoggedEntryViewController.m
//  Aura
//
//  Created by Storm Wright on 8/3/21.
//

#import "LoggedEntryViewController.h"

@interface LoggedEntryViewController ()

@end

@implementation LoggedEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int confettiCount = 200;
    
    NSArray *confettiColors = @[[UIColor colorWithRed: 0.26 green: 0.63 blue: 0.28 alpha: 1.00], [UIColor colorWithRed: 0.49 green: 0.70 blue: 0.26 alpha: 1.00], [UIColor colorWithRed: 0.75 green: 0.79 blue: 0.20 alpha: 1.00], [UIColor colorWithRed: 0.99 green: 0.85 blue: 0.21 alpha: 1.00], [UIColor colorWithRed: 0.98 green: 0.55 blue: 0.00 alpha: 1.00], [UIColor colorWithRed: 0.96 green: 0.32 blue: 0.12 alpha: 1.00], [UIColor colorWithRed: 0.90 green: 0.22 blue: 0.21 alpha: 1.00]];
    
    int screenWidth = self.view.frame.size.width;
    int screenHeight = self.view.frame.size.height;
    int randomStartPoint;
    int randomStartConfettiLength;
    int randomEndConfettiLength;
    int randomEndPoint;
    int randomDelayTime;
    int randomFallTime;
    int randomRotation;
    
    for (int i = 0; i < confettiCount; i++){
        randomStartPoint = arc4random_uniform(screenWidth);
        randomEndPoint = arc4random_uniform(screenWidth);
        randomDelayTime = arc4random_uniform(100);
        randomFallTime = arc4random_uniform(3);
        randomRotation = arc4random_uniform(360);
        randomStartConfettiLength = arc4random_uniform(15);
        randomEndConfettiLength = arc4random_uniform(15);
        NSUInteger randomColor = arc4random() % [confettiColors count];
        
        UIView *confetti=[[UIView alloc]initWithFrame:CGRectMake(randomStartPoint, -10, randomStartConfettiLength, 8)];
        [confetti setBackgroundColor:confettiColors[randomColor]];
        confetti.alpha = .4;
        [self.view addSubview:confetti];
        
        [UIView animateWithDuration:randomFallTime + 5 delay:randomDelayTime * .1 options:UIViewAnimationOptionRepeat animations:^{
                [confetti setFrame:CGRectMake(randomEndPoint, screenHeight + 30, randomEndConfettiLength, 8)];
                confetti.transform = CGAffineTransformMakeRotation(randomRotation);
        } completion:nil];
    }
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
