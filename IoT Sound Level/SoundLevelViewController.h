//
//  FirstViewController.h
//  IoT Sound Level
//
//  Created by Levent Ali on 03/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Feed.h"
#import "FeedDelegate.h"

@interface SoundLevelViewController : UIViewController <FeedDelegate, UIAlertViewDelegate, NSURLConnectionDataDelegate> {
    AVAudioRecorder *recorder;
    NSTimer *levelTimer;
    NSTimer *recordingTimer;
    
    BOOL *sendLocation;
    
//    CLLocationManager *locationManager;
    
    double lowPassResults;
    
    IBOutlet UILabel *currentSoundLevel;
    NSNumber *currentSoundValue;
    
    UIImageView *circle;
    
    Feed *myFeed;
    
    NSMutableData *responseData;
}

@property (nonatomic, retain) UIImageView *circle;

-(void)createCircleView;

- (void)levelTimerCallback:(NSTimer *)timer;
- (void)recordingTimerCallback:(NSTimer *)timer;
- (void)beginAuthorisation;

@end
