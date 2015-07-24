//
//  FrontCameraViewController.h
//  FrontCamera
//
//  Created by Bipin Gohel on 04/11/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface FrontCameraViewController : UIViewController <UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
	UIImageView *green;
	UIImagePickerController *imgPicker;
}

@property (nonatomic,retain)UIImageView *green;
@property (nonatomic,retain) UIImagePickerController *imgPicker;
-(IBAction)startCamera:(id)sender;

-(void)startVideoCapturing;
-(void)stopVideoCapturing;
-(IBAction)playVideo;
@end

