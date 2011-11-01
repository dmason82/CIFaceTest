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
    NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:@"CIDetectorAccuracy",@"CIDetectorAccuracyLow", nil];
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
        CGContextSetLineWidth(context, 10.0);
        CGFloat components[] = {1.0,0.0,0.0,1.0};
        CGColorRef color = CGColorCreate(colorspace, components);
        CGContextSetStrokeColorWithColor(context, color);
        //CGContextMoveToPoint(context, feature.leftEyePosition.x, feature.leftEyePosition.y);
        //CGContextAddLineToPoint(context, feature.rightEyePosition.x, feature.rightEyePosition.y);
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context,self.frame.size.width, self.frame.size.height);
        CGContextStrokePath(context);
        CGColorSpaceRelease(colorspace);
        CGColorRelease(color);
        if([feature hasLeftEyePosition])
        {
            UIView* lEye = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15.0, 15.0)];
            [lEye setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.2]];
            [lEye setCenter:feature.leftEyePosition];
            [self addSubview:lEye];
        }
        if([feature hasRightEyePosition])
        {
            UIView* rEye = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15.0, 15.0)];
            [rEye setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.2]];
            [rEye setCenter:feature.rightEyePosition];
            [self addSubview:rEye];
        }
        if([feature hasMouthPosition])
        {
            UIView* mouth = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15.0, 15.0)];
            [mouth setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.2]];
            [mouth setCenter:feature.mouthPosition];
            [self addSubview:mouth];
        }
    }
    [self setBackgroundColor:[UIColor clearColor]];
    [self setOpaque:YES];
    [self setHidden:NO];
}
@end
