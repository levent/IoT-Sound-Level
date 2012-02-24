//
//  Feed.m
//  IoTally
//
//  Created by Levent Ali on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Feed.h"

@implementation Feed

@synthesize currentValue;
@synthesize feedId;
@synthesize apiKey;
@synthesize updateFrequency;

- (id)initWithUserDefaults

{
    userDefaults = [NSUserDefaults standardUserDefaults];
    feedId = [userDefaults objectForKey:@"feedId"];
    apiKey = [userDefaults objectForKey:@"apiKey"];
    updateFrequency = [userDefaults objectForKey:@"updateFrequency"];
    if(updateFrequency == nil) {
        [self saveUpdateFrequency:[NSNumber numberWithDouble:5.0]];
    }
//    NSLog(@"freq: %@", updateFrequency);
    return self;
}

- (void)saveFeedId:(NSString *)value
{
    feedId = value;
    [userDefaults setObject:value forKey:@"feedId"];
}

- (void)saveApiKey:(NSString *)value
{
    apiKey = value;
    [userDefaults setObject:value forKey:@"apiKey"];
}

- (void)saveUpdateFrequency:(NSNumber *)value
{
    updateFrequency = value;
    [userDefaults setObject:value forKey:@"updateFrequency"];
}

@end
