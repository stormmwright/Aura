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
    
    NSArray *readTypes = @[[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount], [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierPushCount], [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass], [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis]];

    NSArray *writeTypes = @[[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount], [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierPushCount], [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass]];
    
    [self.healthStore requestAuthorizationToShareTypes:[NSSet setWithArray:readTypes]
                                                 readTypes:[NSSet setWithArray:writeTypes] completion:nil];
}

@end
