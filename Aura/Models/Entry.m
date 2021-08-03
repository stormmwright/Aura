//
//  Entry.m
//  Aura
//
//  Created by Storm Wright on 7/23/21.
//

#import "Entry.h"

@implementation Entry

@dynamic entryID;
@dynamic author;
@dynamic mood;
@dynamic createdAt;

+ (nonnull NSString *)parseClassName {
    return @"Entry";
}

+ (void) logUserEntry: ( NSString * _Nullable )mood withCompletion: (PFBooleanResultBlock _Nullable)completion {
    Entry *newEntry = [Entry new];
    newEntry.author = [PFUser currentUser];
    newEntry.mood = mood;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    // convert date to string
    NSString *createdAtString = [formatter stringFromDate:newEntry.createdAt];
    // convert string to date
    newEntry.createdAt = [formatter dateFromString:createdAtString];
    
    [newEntry saveInBackgroundWithBlock:completion];
}

@end
