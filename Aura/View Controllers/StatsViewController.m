//
//  StatsViewController.m
//  Aura
//
//  Created by Storm Wright on 7/24/21.
//

#import "StatsViewController.h"
#import <FSCalendar/FSCalendar.h>

@interface StatsViewController () <FSCalendarDelegate, FSCalendarDataSource>

@property (weak, nonatomic) IBOutlet UIView *calendarView;
@property (weak, nonatomic) IBOutlet UIView *chartView;

@end

@implementation StatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)switchViews:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.calendarView.alpha = 1;
        self.chartView.alpha = 0;
    } else {
        self.calendarView.alpha = 0;
        self.chartView.alpha = 1;
    }
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
    // Do other updates here
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
