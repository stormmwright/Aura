//
//  Entry.h
//  Aura
//
//  Created by Storm Wright on 7/23/21.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Entry : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *entryID;
@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) NSString *mood;
@property (nonatomic, strong) NSDate *createdAt;

+ (void) logUserEntry: ( NSString * _Nullable )mood withCompletion: (PFBooleanResultBlock _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
