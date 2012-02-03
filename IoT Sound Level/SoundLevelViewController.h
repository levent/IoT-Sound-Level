//
//  FirstViewController.h
//  IoT Sound Level
//
//  Created by Levent Ali on 03/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundLevelViewController : UIViewController {
    AVAudioRecorder *recorder;
    NSTimer *levelTimer;
    
    double lowPassResults;
    
    IBOutlet UILabel *currentSoundLevel;
}

- (void)levelTimerCallback:(NSTimer *)timer;

@end
