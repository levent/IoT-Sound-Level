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

@interface SoundLevelViewController : UIViewController <FeedDelegate, UIAlertViewDelegate> {
    AVAudioRecorder *recorder;
    NSTimer *levelTimer;
    
    double lowPassResults;
    
    IBOutlet UILabel *currentSoundLevel;
    
    UIImageView *circle;
    
    Feed *myFeed;
}

@property (nonatomic, retain) UIImageView *circle;

-(void)createCircleView;

- (void)levelTimerCallback:(NSTimer *)timer;
- (void)beginAuthorisation;

@end
