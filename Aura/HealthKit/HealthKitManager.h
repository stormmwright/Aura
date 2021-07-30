//
//  HealthKitManager.h
//  Aura
//
//  Created by Storm Wright on 7/28/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HealthKitManager : NSObject

+ (HealthKitManager *)sharedManager;

- (void)requestAuth;

- (void)getStepCount;

- (void)getPushCount;

- (void)getWeight;

- (void)getSleepTime;

@end

NS_ASSUME_NONNULL_END
