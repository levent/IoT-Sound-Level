//
//  FeedDelegate.h
//  IoTally
//
//  Created by Levent Ali on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Feed;

@protocol FeedDelegate <NSObject>

@optional
- (id)initWithFeed:(Feed *)feed;
- (id)initWithNibNameAndFeed:(NSString *)nibNameOrNil feed:(Feed *)feed bundle:(NSBundle *)nibBundleOrNil;


@end
