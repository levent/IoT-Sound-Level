//
//  Feed.h
//  IoTally
//
//  Created by Levent Ali on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feed : NSObject {
    NSUserDefaults *userDefaults;
}
@property (nonatomic, retain) NSString *currentValue;
@property (nonatomic, retain) NSString *feedId;
@property (nonatomic, retain) NSString *apiKey;
@property (nonatomic, retain) NSNumber *updateFrequency;
-(id)initWithUserDefaults;
-(void)saveFeedId: (NSString *)value;
-(void)saveApiKey: (NSString *)value;
-(void)saveUpdateFrequency: (NSNumber *)value;
@end
