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
    
    for (CIFaceFeature* feature in facialFeatures) 
    {
        NSLog(@"%i",[feature hasMouthPosition]);
        NSLog(@"%f,%f",feature.mouthPosition.x,feature.mouthPosition.y);
        NSLog(@"%f,%f",feature.leftEyePosition.x,feature.leftEyePosition.y);
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(context);
        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        CGContextSetLineWidth(context, 3.0);
        CGFloat components[] = {1.0,0.0,0.0,1.0};
        CGColorRef color = CGColorCreate(colorspace, components);
        CGContextSetStrokeColorWithColor(context, color);
        CGContextMoveToPoint(context, feature.leftEyePosition.x, feature.leftEyePosition.y);
        CGContextAddLineToPoint(context, feature.rightEyePosition.x, feature.rightEyePosition.y);
        CGContextStrokePath(context);
        CGColorSpaceRelease(colorspace);
        CGColorRelease(color);
    }
    [super drawRect:rect];
}
@end
