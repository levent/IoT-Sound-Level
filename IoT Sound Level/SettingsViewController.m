//
//  SecondViewController.m
//  IoTally
//
//  Created by Levent Ali on 27/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "OAuthRequestController.h"

#import "PachubeAppCredentials.h"

@implementation SettingsViewController

@synthesize accessToken;

- (id)initWithNibNameAndFeed:(NSString *)nibNameOrNil feed:(Feed *)feed bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        myFeed = feed;
        self.title = NSLocalizedString(@"Settings", @"Settings");
        self.tabBarItem.image = [UIImage imageNamed:@"157-wrench"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadSettings];
    if (myFeed.apiKey == nil || myFeed.feedId == nil) {
        [infoField setText:@"Please login to Pachube"];
        [feedIdField setEnabled:NO];
        [saveButton setHidden:YES];
        [loginButton setHidden:NO];
        [saveButton setTitle:@"Login" forState:UIControlStateNormal];
    }
    else
    {
        [infoField setText:@"This audio is linked to feed"];
        [feedIdField setEnabled:YES];
        [saveButton setHidden:NO];
        [loginButton setHidden:YES];
        [saveButton setTitle:@"Update" forState:UIControlStateNormal];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)loadSettings {
    [feedIdField setText:myFeed.feedId];
}

-(IBAction)saveSettings:(id)sender {
    if (feedIdField.text != (id)[NSNull null] && feedIdField.text.length != 0) {
        [myFeed saveFeedId:feedIdField.text];
    }
    [self backgroundClick:sender];
}

- (IBAction)backgroundClick:(id)sender {
    [feedIdField resignFirstResponder];
}

- (IBAction)beginAuthorisation:(id)sender {
    OAuthRequestController *oauthController = [[OAuthRequestController alloc] initWithFeed:myFeed];
    [self presentModalViewController:oauthController animated:YES];
}

@end
