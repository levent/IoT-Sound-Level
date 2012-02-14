//
//  SecondViewController.h
//  IoTally
//
//  Created by Levent Ali on 27/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FeedDelegate.h"
#import "Feed.h"

@interface SettingsViewController : UIViewController <FeedDelegate> {
//    NSString *feedId;
//    NSString *apiKey;
    
    Feed *myFeed;
    
    IBOutlet UITextField *feedIdField;
    IBOutlet UILabel *infoField;
    IBOutlet UIButton *saveButton;
    IBOutlet UIButton *loginButton;
    
    IBOutlet UISlider *updateFrequency;
    IBOutlet UILabel *updateFrequencyValue;
}
@property (nonatomic, retain) NSString *accessToken;

- (IBAction)saveSettings:(id)sender;
- (IBAction)backgroundClick:(id)sender;
- (IBAction)beginAuthorisation:(id)sender;
- (IBAction)frequencyChanged:(id)sender;

- (void)loadSettings;
@end
