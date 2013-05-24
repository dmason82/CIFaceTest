//
//  OCGViewController.h
//  VampTest
//
//  Created by Doug Mason on 10/18/11.
//  Copyright (c) 2011 Doug Mason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface OCGViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
@property(nonatomic,retain)IBOutlet UIButton* captureButton;
@property(nonatomic,retain)IBOutlet UIButton* analyseButton;
@property(nonatomic,retain)IBOutlet UIImageView* pictureView;


-(IBAction)capture:(id)sender;
-(IBAction)analyse:(id)sender;
@end
