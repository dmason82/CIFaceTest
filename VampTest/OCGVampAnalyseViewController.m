//
//  OCGVampAnalyseViewController.m
//  VampTest
//
//  Created by Doug Mason on 10/20/11.
//  Copyright (c) 2011 Observation Chair Group. All rights reserved.
//

#import "OCGVampAnalyseViewController.h"
#import "OCGAppDelegate.h"
#import "OCGImageView.h"
#import <QuartzCore/QuartzCore.h>
@implementation OCGVampAnalyseViewController
@synthesize pictureView;
@synthesize facialFeatures;
@synthesize overlay;
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
    NSLog(@"%@",im);
    [overlay setBackgroundColor:[UIColor clearColor]];
    //[overlay setOpaque:NO];
    [self.overlay setTransform:CGAffineTransformMakeScale(1, -1)];
    [self.view.window setTransform:CGAffineTransformMakeScale(1, -1)];
    [overlay setNeedsDisplay];
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
    CGPoint pt = overlay.bounds.origin;
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsBeginImageContext(overlay.bounds.size);
    context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-(int)pt.x, -(int)pt.y));
    [self.view.window.layer renderInContext:context];
    UIImage* saveBuf = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-YYYY HH-MM"];
   NSArray* search = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDirectory, YES);
    NSString* path = [[search lastObject] stringByAppendingFormat:@"/%@.png",[formatter stringFromDate:date]];
    NSError* error = nil;
    NSData* data = UIImagePNGRepresentation(saveBuf);
    NSFileManager* manager = [NSFileManager defaultManager];
    if( ![manager fileExistsAtPath:path])
    {
        NSLog(@"Creating new file at %@",path);
        [manager createFileAtPath:path contents:data attributes:nil];
    }
    else if ([data writeToURL:[NSURL URLWithString:path] options:NSDataWritingAtomic error:&error]) 
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Saved Successfully" message:[NSString stringWithFormat:@"Saved image to path %@ successfully",path] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Save failed!" message:[NSString stringWithFormat:@"Save to path %@ failed with error %@",path,error] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    //UIImageWriteToSavedPhotosAlbum(saveBuf, self, @selector(nil), nil);
    
}
-(IBAction)share:(id)sender
{
    
}
-(IBAction)again:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
//TODO: Implement method first creating a UIImage from the Overlay view, then composting the two together... Then we can do stuff. 
-(UIImage*)mergeImage:(UIImage *)image withOverlay:(UIImage *)overlay
{
//    CGPoint point = CGPointMake(self.pictureView.frame.origin.x,self.pictureView.frame.origin.y);
//    CGSize size = CGSizeMake(self.pictureView.frame.size.width, self.pictureView.frame.size.height);
//    UIGraphicsBeginImageContext(size);
//    im
    
    return nil;
}
@end
