//
//  SecondViewController.h
//  IoTally
//
//  Created by Levent Ali on 27/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SettingsViewController : UIViewController {
    NSString *feedId;
    NSString *apiKey;
    
    IBOutlet UITextField *feedIdField;
    IBOutlet UITextField *apiKeyField;
}

-(IBAction)saveSettings:(id)sender;
-(IBAction)backgroundClick:(id)sender;
@end
