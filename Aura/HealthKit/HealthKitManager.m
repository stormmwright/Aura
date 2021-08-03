//
//  HealthKitManager.m
//  Aura
//
//  Created by Storm Wright on 7/28/21.
//

#import "HealthKitManager.h"
#import <HealthKit/HealthKit.h>

@interface HealthKitManager ()

@property (retain, nonatomic) HKHealthStore *healthStore;

@end

@implementation HealthKitManager

+ (HealthKitManager *)sharedManager {
    static dispatch_once_t pred = 0;
        static HealthKitManager *instance = nil;
        dispatch_once(&pred, ^{
            instance = [[HealthKitManager alloc] init];
            instance.healthStore = [[HKHealthStore alloc] init];
        });
        return instance;
}

- (void)requestAuth {
    if ([HKHealthStore isHealthDataAvailable] == NO) {
        return;
    }
    
    NSArray *allTypes = @[[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount], [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierPushCount], [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass], [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis]];
    
    [self.healthStore requestAuthorizationToShareTypes:[NSSet setWithArray:allTypes]
                                             readTypes:[NSSet setWithArray:allTypes] completion:nil];
}

- (void)getStepCountWithCompletion:(void(^)(double value, NSError *error))completion {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *interval = [calendar components:NSCalendarUnitDay fromDate:[NSDate date]];
    interval.day = 7;

    // set the anchor for 12 a.m. on Sunday
    NSDateComponents *anchorComponents = [calendar components:NSCalendarUnitTimeZone | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday fromDate:[NSDate date]];
    anchorComponents.timeZone = calendar.timeZone;
    anchorComponents.hour = 0;
    anchorComponents.minute = 0;
    anchorComponents.second = 0;
    anchorComponents.weekday = 1;
    
    
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];

    // create the query
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:nil options:HKStatisticsOptionCumulativeSum anchorDate:anchorDate intervalComponents:interval];

    // set the results handler
    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *results, NSError *error) {
        if (error) {
            // perform proper error handling here
            NSLog(@"*** An error occurred while calculating the statistics: %@ ***",error.localizedDescription);
        }

        NSDate *endDate = [NSDate date];
        NSDate *startDate = [calendar dateByAddingComponents:anchorComponents toDate:endDate options:0];

        // plot the daily step counts over the past 7 days
        [results enumerateStatisticsFromDate:startDate
                                      toDate:endDate
                                   withBlock:^(HKStatistics *result, BOOL *stop) {

                                       HKQuantity *quantity = result.sumQuantity;
                                       if (quantity) {
                                           NSDate *date = result.startDate;
                                           double value = [quantity doubleValueForUnit:[HKUnit countUnit]];
                                           completion(value, nil);
                                           NSLog(@"Start Date: %@", date);
                                           NSLog(@"Sum Quantity: %.0f", value);
                                       } else {
                                           NSLog(@"Start Date: Null");
                                           NSLog(@"Sum Quantity: 0");
                                       }

                                   }];
    };

    [self.healthStore executeQuery:query];
}

- (void)getPushCountWithCompletion:(void(^)(double value, NSError *error))completion {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *interval = [calendar components:NSCalendarUnitDay fromDate:[NSDate date]];
    interval.day = 7;

    // set the anchor for 12 a.m. on Sunday
    NSDateComponents *anchorComponents = [calendar components:NSCalendarUnitTimeZone | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday fromDate:[NSDate date]];
    anchorComponents.timeZone = calendar.timeZone;
    anchorComponents.hour = 0;
    anchorComponents.minute = 0;
    anchorComponents.second = 0;
    anchorComponents.weekday = 1;
    
    
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierPushCount];

    // create the query
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:nil options:HKStatisticsOptionCumulativeSum anchorDate:anchorDate intervalComponents:interval];

    // set the results handler
    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *results, NSError *error) {
        if (error) {
            // perform proper error handling here
            NSLog(@"*** An error occurred while calculating the statistics: %@ ***",error.localizedDescription);
        }

        NSDate *endDate = [NSDate date];
        NSDate *startDate = [calendar dateByAddingComponents:anchorComponents toDate:endDate options:0];

        // plot the daily step counts over the past 7 days
        [results enumerateStatisticsFromDate:startDate
                                      toDate:endDate
                                   withBlock:^(HKStatistics *result, BOOL *stop) {

                                       HKQuantity *quantity = result.sumQuantity;
                                       if (quantity) {
                                           NSDate *date = result.startDate;
                                           double value = [quantity doubleValueForUnit:[HKUnit countUnit]];
                                           completion(value, nil);
                                           NSLog(@"Start Date: %@", date);
                                           NSLog(@"Sum Quantity: %.0f", value);
                                       } else {
                                           NSLog(@"Start Date: Null");
                                           NSLog(@"Sum Quantity: 0");
                                       }

                                   }];
    };

    [self.healthStore executeQuery:query];
}

// TODO: get weight
- (void)getWeight {
    NSLog(@"Start Date: Null");
    NSLog(@"Sum Quantity: 0");
}

// TODO: get sleep time
- (void)getSleepTime {
    NSLog(@"Start Date: Null");
    NSLog(@"Sum Quantity: 0");
}

// TODO: get updates from HealthKit

@end
