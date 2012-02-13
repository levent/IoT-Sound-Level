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

- (id)initWithUserDefaults

{
    userDefaults = [NSUserDefaults standardUserDefaults];
    feedId = [userDefaults objectForKey:@"feedId"];
    apiKey = [userDefaults objectForKey:@"apiKey"];
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

@end
