//
//  OCGVampAnalyseViewController.h
//  VampTest
//
//  Created by Doug Mason on 10/20/11.
//  Copyright (c) 2011 Observation Chair Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCGVampAnalyseViewController : UIViewController

@property(nonatomic,retain)IBOutlet UIImageView* pictureView;
-(IBAction)save:(id)sender;
-(IBAction)share:(id)sender;
-(IBAction)again:(id)sender;

@end
