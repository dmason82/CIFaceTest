//
//  OCGVampAnalyseViewController.m
//  VampTest
//
//  Created by Doug Mason on 10/20/11.
//  Copyright (c) 2011 Observation Chair Group. All rights reserved.
//

#import "OCGVampAnalyseViewController.h"
#import "OCGAppDelegate.h"
@implementation OCGVampAnalyseViewController
@synthesize pictureView;
@synthesize facialFeatures;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/
-(void)viewDidLoad
{
    CGImageRef cgImage= [[((OCGAppDelegate*)[[UIApplication sharedApplication] delegate]) image] CGImage];
    UIImage* im = [[UIImage alloc] initWithCGImage:cgImage];
    [self.pictureView setImage:im];
    [self.pictureView setHidden:NO];
    NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:@"CIDetectorAccuracy",@"CIDetectorAccuracyHigh", nil];
    CIImage* image = [[CIImage alloc] initWithImage:im];
    NSLog(@"%@",image);
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:options];
    facialFeatures = [detector featuresInImage:image];
    NSLog(@"%d",[facialFeatures count]);
    for (CIFeature* feature in facialFeatures) {
        NSLog(@"%@",feature.type);
    }
    NSLog(@"%@",facialFeatures);
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)save:(id)sender
{
    
}
-(IBAction)share:(id)sender
{
    
}
-(IBAction)again:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


@end
