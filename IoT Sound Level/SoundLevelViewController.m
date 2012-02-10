//
//  FirstViewController.m
//  IoT Sound Level
//
//  Created by Levent Ali on 03/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SoundLevelViewController.h"



#define kCIRCLE_WIDTH_PERCENT 90
#define kCIRCLE_TOP_MARGIN 29

#define kTIMER_INTERVAL 0.10 

#define kMIN_DB -60
#define kMAX_DB 10

@implementation SoundLevelViewController

@synthesize circle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Sound Level", @"Sound Level");
        self.tabBarItem.image = [UIImage imageNamed:@"66-microphone"];
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

    [self createCircleView];
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
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
                              [NSNumber numberWithInt:kAudioFormatAppleLossless], AVFormatIDKey,
                              [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
                              [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey,
                              nil];
    
    NSError *error;
    
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
    if (recorder) {
        [recorder prepareToRecord];
        recorder.meteringEnabled = YES;
        [recorder record];
		levelTimer = [NSTimer scheduledTimerWithTimeInterval: kTIMER_INTERVAL
                                                      target: self 
                                                    selector: @selector(levelTimerCallback:) 
                                                    userInfo: nil 
                                                     repeats: YES];
//		levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    } else {
        NSLog(@"%@",[error description]);
    }
}

-(void)createCircleView
{
    const int circleMaxWidth = self.view.frame.size.width * 0.9;
    
    
    CGColorRef backgroundColor;

    backgroundColor = [UIColor orangeColor].CGColor;

    
	const CGFloat *backgroundColorComps = CGColorGetComponents(backgroundColor);
    
    CGSize yourSize = CGSizeMake(circleMaxWidth, circleMaxWidth);				// Canvas
	CGRect yourRect = CGRectMake(0,0, circleMaxWidth, circleMaxWidth);				// Rectangulo para dibujar
    
	// Context.
    UIGraphicsBeginImageContextWithOptions(yourSize, NO, 0.f);     // 0.f: Device default scale
    
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetAllowsAntialiasing(context, true);
	CGContextSetShouldAntialias(context, true);
    
	CGContextAddEllipseInRect(context, yourRect);
	CGContextClip(context);
    
    CGContextSetRGBFillColor(context, backgroundColorComps[0] , 
                             backgroundColorComps[1], 
                             backgroundColorComps[2], 
                             backgroundColorComps[3]);
    
	CGContextFillEllipseInRect(context, yourRect);	
        
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
    
    self.circle = [[UIImageView alloc] initWithImage:image];    
    self.circle.frame = CGRectMake((self.view.frame.size.width-circleMaxWidth)/2, kCIRCLE_TOP_MARGIN, circleMaxWidth, circleMaxWidth);
    [self.view addSubview:self.circle];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    currentSoundLevel.text = @"-";
    if (recorder) {
        [levelTimer invalidate];
        levelTimer = nil;
        [recorder stop];
        recorder = nil;
    }
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

- (void)levelTimerCallback:(NSTimer *)timer {
//	NSLog(@"Average input: %f Peak input: %f", [recorder averagePowerForChannel:0], [recorder peakPowerForChannel:0]);

    [recorder updateMeters];
    
    float currentSoundMeasure = [recorder averagePowerForChannel:0];
    
	const double ALPHA = 0.05;
	double peakPowerForChannel = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
	lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * lowPassResults;
    currentSoundLevel.text = [NSString stringWithFormat:@"%.2fdb", currentSoundMeasure];
    
    // Animate circle:
    
    [UIView animateWithDuration:kTIMER_INTERVAL 
                          delay:0.0 
                        options:UIViewAnimationCurveEaseIn
                     animations:^{
                         
                         float totalRange = (kMIN_DB-kMAX_DB)*-1;
                         float currentMagnitude = totalRange - abs(roundf(currentSoundMeasure));
                         
                         float totalPercent = currentMagnitude / totalRange;
                         
                         float newCircleWidth = self.view.frame.size.width * totalPercent;
                         
                         self.circle.frame = CGRectMake((self.view.frame.size.width-newCircleWidth)/2, 
                                                        kCIRCLE_TOP_MARGIN+((self.view.frame.size.width-newCircleWidth)/2), 
                                                        newCircleWidth, 
                                                        newCircleWidth);
                         
                     }
                     completion:nil];
    
    
    
    
//	NSLog(@"Average input: %f Peak input: %f Low pass results: %f", [recorder averagePowerForChannel:0], [recorder peakPowerForChannel:0], lowPassResults);

}

//- (void)listenForBlow:(NSTimer *)timer {
//	[recorder updateMeters];
//    
//	const double ALPHA = 0.05;
//	double peakPowerForChannel = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
//	lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * lowPassResults;
//    
//	if (lowPassResults > 0.95)
//		NSLog(@"Mic blow detected");
//}

@end
