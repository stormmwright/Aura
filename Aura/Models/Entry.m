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
    
    [newEntry saveInBackgroundWithBlock:completion];
}

@end
