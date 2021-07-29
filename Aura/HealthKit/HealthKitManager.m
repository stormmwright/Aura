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

//    NSArray *readTypes = @[[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount], [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierPushCount], [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass], [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis]];
//
//    NSArray *writeTypes = @[[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount], [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierPushCount], [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass]];
    
    // array of all of the objects neccessary to save a correlation for the sample code
    NSArray *allTypes = @[[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed]];
    
    // app asks for permission to share all of the contained objects neccessary for saving a correlation
    [self.healthStore requestAuthorizationToShareTypes:[NSSet setWithArray:allTypes]
                                             readTypes:[NSSet setWithArray:allTypes] completion:nil];
}

// sample code that uses the correlation query to search for food samples with more than 800 calories
- (void)findCorrelation {
    // begins by setting up an array to store our high calorie foods
    NSMutableArray *highCalorieFoods = [NSMutableArray array];
    // creates a predicate that matches quantities greater than or equal to 800 kcal
    HKQuantity *highCalorie = [HKQuantity quantityWithUnit:[HKUnit kilocalorieUnit]
                                               doubleValue:800.0];
    
    NSPredicate *greaterThanHighCalorie =
    [HKQuery predicateForQuantitySamplesWithOperatorType:
     NSGreaterThanOrEqualToPredicateOperatorType quantity:highCalorie];
     
    // creates a dictionary using a quantity type object for dietary energy consumed as the key and the newly-created predicate as the value
    HKQuantityType *energyConsumed =
    [HKObjectType quantityTypeForIdentifier:
     HKQuantityTypeIdentifierDietaryEnergyConsumed];
     
    // uses this dictionary as the sample predicates for a correlation query
    NSDictionary *samplePredicates = @{energyConsumed : greaterThanHighCalorie};
     
    HKCorrelationType *foodType =
    [HKCorrelationType correlationTypeForIdentifier:HKCorrelationTypeIdentifierFood];
     
    HKCorrelationQuery *query =
    [[HKCorrelationQuery alloc]
     initWithType:foodType predicate:nil
     samplePredicates:samplePredicates
     completion:^(HKCorrelationQuery *query, NSArray *correlations, NSError *error) {
        // checks to see if an error occurred
        if (correlations == nil) {
             // Provide proper error handling here...
             NSLog(@"An error occurred while searching for high calorie food: %@",
                  error.localizedDescription);
             abort();
         }
        // adds the results to the array of high calorie foods
         for (HKCorrelation *correlation in correlations) {
             [highCalorieFoods addObject:correlation];
//             [highCalorieFoods addObjectsFromArray:correlation];
         }
        // logs the number of matching samples found, and the contents of the high calorie foods array
         NSLog(@"Found %lu foods: %@", (unsigned long)[highCalorieFoods count], highCalorieFoods);
     
     }];
    
    // executes the query on the HeathKit store
    [self.healthStore executeQuery:query];
}

//- (double)readStepCount {
//    NSError *error;
//    HKQuantityType *stepCount = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//}

@end
