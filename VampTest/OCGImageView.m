//
//  OCGImageView.m
//  VampTest
//
//  Created by Doug Mason on 10/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OCGImageView.h"
#import "OCGAppDelegate.h"
@implementation OCGImageView
@synthesize facialFeatures;
-(void)drawRect:(CGRect)rect
{
    
    NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:@"CIDetectorAccuracy",@"CIDetectorAccuracyHigh", nil];
    CGImageRef cgim = [[(OCGAppDelegate*)[[UIApplication sharedApplication] delegate] image] CGImage];
    UIImage* im = [[UIImage alloc] initWithCGImage:cgim];
    CIImage* image = [[CIImage alloc] initWithImage:im];
    if (image == nil) {
        NSLog(@"Nil image in App Delegate");
    }
    NSLog(@"%@",image);
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:options];
    facialFeatures = [detector featuresInImage:image];
    NSLog(@"%d",[facialFeatures count]);
    float ratioh = self.frame.size.height/im.size.height;
    float ratiow = self.frame.size.width/ im.size.width;
    NSLog(@"Height ratio: %f",ratioh);
    NSLog(@"Width ratio: %f",ratiow);
    for (CIFaceFeature* feature in facialFeatures) 
    {
        NSLog(@"%i",[feature hasMouthPosition]);
        NSLog(@"%f,%f",feature.mouthPosition.x,feature.mouthPosition.y);
        NSLog(@"%f,%f",feature.leftEyePosition.x,feature.leftEyePosition.y);
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(context);
        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        CGContextSetLineWidth(context, 10.0);
        CGFloat components[] = {1.0,0.0,0.0,1.0};
        CGColorRef color = CGColorCreate(colorspace, components);
        CGContextSetStrokeColorWithColor(context, color);
        CGContextMoveToPoint(context, (feature.leftEyePosition.x*ratiow)-5.0, feature.leftEyePosition.y*ratioh);
        CGContextAddLineToPoint(context, feature.rightEyePosition.x*ratiow+5.0, feature.rightEyePosition.y*ratioh);
        CGContextStrokePath(context);
        CGColorRelease(color);
        CGContextSetLineWidth(context, 5.0);
        CGFloat mComponents[] = {0.1,0.0,0.9,1.0};
        color = CGColorCreate(colorspace, mComponents);
        CGContextSetStrokeColorWithColor(context, color);
        CGContextMoveToPoint(context, feature.mouthPosition.x*ratiow, feature.mouthPosition.y*ratioh);
        CGContextAddLineToPoint(context, (feature.mouthPosition.x*ratiow)+8, (feature.mouthPosition.y*ratioh)-7);
        CGContextStrokePath(context);
        CGColorSpaceRelease(colorspace);
        CGColorRelease(color);
    }
    [self setBackgroundColor:[UIColor clearColor]];
    [self setOpaque:YES];
    [self setHidden:NO];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches) {
        NSLog(@"%@",t.description);
    }
}
@end
