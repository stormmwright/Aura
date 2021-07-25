//
//  CalendarViewController.m
//  Aura
//
//  Created by Storm Wright on 7/24/21.
//

#import "CalendarViewController.h"
#import <FSCalendar/FSCalendar.h>
#import "Entry.h"

@interface CalendarViewController () <FSCalendarDelegate, FSCalendarDataSource>

@property (weak, nonatomic) IBOutlet FSCalendar *calendar;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchEntries];
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
    // Do other updates here
}

- (void)fetchEntries {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Entry"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *entries, NSError *error) {
        if (entries != nil) {
            NSLog(@"%@", entries);
        } else {
            NSLog(@"%@", error.localizedDescription);
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
