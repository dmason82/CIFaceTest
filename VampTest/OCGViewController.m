//
//  OCGViewController.m
//  VampTest
//
//  Created by Doug Mason on 10/18/11.
//  Copyright (c) 2011 Observation Chair Group. All rights reserved.
//

#import "OCGViewController.h"
#import "OCGVampAnalyseViewController.h"
#import "OCGAppDelegate.h"
@implementation OCGViewController
@synthesize captureButton,analyseButton;
@synthesize pictureView;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    [self.captureButton setBackgroundColor:[UIColor redColor]];
    [self.analyseButton setTintColor:[UIColor greenColor]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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



#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self.pictureView setImage:image];
    [self.pictureView setHidden:NO];
    [picker dismissModalViewControllerAnimated:YES];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if([[info valueForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage])
    {
        [self.pictureView setImage:(UIImage*)[info valueForKey:UIImagePickerControllerOriginalImage]];
        [((OCGAppDelegate*)[[UIApplication sharedApplication] delegate]) setImage:(UIImage*)[info valueForKey:UIImagePickerControllerOriginalImage]];
        [self.pictureView setHidden:NO];
    }
    
    [picker dismissModalViewControllerAnimated:YES];
}
#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    [picker setEditing:YES];
    [picker setTitle:@"Capture image of potential vampire"];
    [picker setDelegate:self];
        if (buttonIndex == 0)
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) 
            {
                [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            }
            else
            {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Invalid Source" message:@"Your camera may not be working, please select another source:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Photo Library",@"Saved Photos", nil];
                [alert show];
                return;
            }
        }
        else if(buttonIndex == 1){
            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        else if (buttonIndex == 2)
        {
            

            [picker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        }
        else  
        {
            return;
        }
    [self presentModalViewController:picker animated:YES];
}

-(void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    
}
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //TODO:Implement Picker selection for Alert View on Camera not being available
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    [picker setEditing:NO];
    if(buttonIndex == 0)
    {
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else
    {
        [picker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
    [self presentModalViewController:picker animated:YES];
    
}
#pragma mark - User Interaction

-(IBAction)capture:(id)sender
{
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"Select the source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Library",@"Saved Photos", nil];
    [sheet showInView:self.view];
}
-(IBAction)analyse:(id)sender
{
    /*OCGVampAnalyseViewController* analyse = [[OCGVampAnalyseViewController alloc] init];
    [analyse setPictureView:[[UIImageView alloc] initWithImage:self.pictureView.image]];*/
    [self performSegueWithIdentifier:@"AnalyseSegue" sender:self];
    //[self performSegueWithIdentifier:@"AnalyseSegue" sender:self];
}
@end
