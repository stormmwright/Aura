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

//- (double)readStepCount {
//    NSError *error;
//    HKQuantityType *stepCount = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//
//}

@end
