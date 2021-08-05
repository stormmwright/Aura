//
//  CalendarViewController.m
//  Aura
//
//  Created by Storm Wright on 7/24/21.
//

#import "CalendarViewController.h"
#import <FSCalendar/FSCalendar.h>
#import <DateTools/DateTools.h>
#import "Entry.h"

@interface CalendarViewController () <FSCalendarDelegate, FSCalendarDataSource>

@property (weak, nonatomic) IBOutlet FSCalendar *calendar;

@property (strong, nonatomic) NSDateFormatter *formatter;

@property (strong, nonatomic) NSDictionary *fillDefaultColors;

@property (strong, nonatomic) NSArray *arrayOfEntries;

@property (strong, nonatomic) NSMutableDictionary *dictOfEntries;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchEntries];
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
    // do other updates here
}

- (void)fetchEntries {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Entry"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *entries, NSError *error) {
        if (entries != nil) {
//            NSLog(@"%@", entries);
            self.arrayOfEntries = entries;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

// TODO: pair entry data with corresponding colors

- (UIColor *)getColor:(NSString *)mood {
    NSDictionary *fillDefaultColors = @{@"Best":[UIColor colorWithRed: 0.26 green: 0.63 blue: 0.28 alpha: 1.00], @"Very Good":[UIColor colorWithRed: 0.49 green: 0.70 blue: 0.26 alpha: 1.00],@"Good":[UIColor colorWithRed: 0.75 green: 0.79 blue: 0.20 alpha: 1.00], @"Neutral":[UIColor colorWithRed: 0.99 green: 0.85 blue: 0.21 alpha: 1.00], @"Bad":[UIColor colorWithRed: 0.98 green: 0.55 blue: 0.00 alpha: 1.00], @"Very Bad":[UIColor colorWithRed: 0.96 green: 0.32 blue: 0.12 alpha: 1.00], @"Worst":[UIColor colorWithRed: 0.90 green: 0.22 blue: 0.21 alpha: 1.00]};
    
    return fillDefaultColors[mood];
}

- (void)getMood:(NSDate *)date {
    PFQuery *query = [PFQuery queryWithClassName:@"Entry"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    
    NSDateComponents *day = [[NSDateComponents alloc] init];
    day.day = 1;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [calendar dateByAddingComponents:day toDate:date options:0];
    
    [query whereKey:@"createdAt" greaterThanOrEqualTo:date];
    [query whereKey:@"createdAt" lessThan:nextDate];
    query.limit = 1;
    
    NSLog(@"Date: @%@", date);
    NSLog(@"Next Date: @%@", nextDate);
    
    __block Entry *entry = nil;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *entries, NSError *error) {
        if (entries != nil) {
            NSLog(@"Mood query: %@", entries);
            entry = entries.firstObject;
            NSLog(@"Mood color: @%@", [self getColor:entry.mood]);
            self.dictOfEntries[entry.createdAt] = entry;
        } else {
            NSLog(@"%@", error.localizedDescription);
        
        }
    }];
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date {
    [self getMood:date];
    
    return nil;
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
