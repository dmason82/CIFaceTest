//
//  OCGVampAnalyseViewController.h
//  VampTest
//
//  Created by Doug Mason on 10/20/11.
//  Copyright (c) 2011 Observation Chair Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
@class OCGImageView;
@interface OCGVampAnalyseViewController : UIViewController
{
    NSArray* facialFeatures;
}
@property(nonatomic,retain)IBOutlet UIImageView* pictureView;
@property(nonatomic,retain)NSArray* facialFeatures;
@property(nonatomic,retain)IBOutlet OCGImageView* overlay;
-(IBAction)save:(id)sender;
-(IBAction)share:(id)sender;
-(IBAction)again:(id)sender;
-(UIImage*)mergeImage:(UIImage*)image withOverlay:(UIImage*)overlay;
@end
