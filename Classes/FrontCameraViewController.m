//
//  FrontCameraViewController.m
//  FrontCamera
//
//  Created by Bipin Gohel on 04/11/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FrontCameraViewController.h"
#import "CameraView.h"
#import "MoviePlayerParentViewController.h"

@implementation FrontCameraViewController
@synthesize green,imgPicker;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSTimer *timerForStartVideoCapaturing = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(startVideoCapturing) userInfo:nil repeats:NO];
	
	NSTimer *timerForStopVideoCapaturing = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(stopVideoCapturing) userInfo:nil repeats:NO];
	
	/*green = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"green.png"]];
	[green setFrame:CGRectMake(0,0,80,80)];
	[self.view addSubview:green];
	[green release];*/
	
	
	
	
	/*
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES){
			UIImagePickerController *frontCamera=[[UIImagePickerController alloc]init]; //WithNibName:@"FrontCameraViewController" bundle:nil];
			
			
//			UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Camera is available and ready" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			[alertview show];
//			[alertview release];
			
			NSArray *media =[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]; 
			
			NSLog(@"media :%@",[media description]);
			
			if ([media containsObject:(NSString *)kUTTypeMovie]) {
				
//				UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Camera is available For video Recording" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//				[alertview show];
//				[alertview release];
				
				frontCamera.sourceType=UIImagePickerControllerSourceTypeCamera;
				frontCamera.mediaTypes=[NSArray arrayWithObject:(NSString *)kUTTypeMovie];
			//frontCamera.cameraDevice=UIImagePickerControllerCameraDeviceRear;
				
			//	frontCamera.cameraCaptureMode=UIImagePickerControllerCameraCaptureModeVideo;
			//	frontCamera.videoQuality=UIImagePickerControllerQualityTypeHigh;
			//	frontCamera.delegate=self;
				
				[self presentModalViewController:frontCamera animated:YES];
				[frontCamera release];
			//	[frontCamera startVideoCapture];
				
				
			}
			else {
				UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Camera is not available For video Recording" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alertview show];
				[alertview release];
			}

			
		}
		else
		{
			
			UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Camera is not available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alertview show];
			[alertview release];
		}								
	 
/*	UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
	
	NSArray* mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
	if ([mediaTypes containsObject:(NSString*)kUTTypeImage]) 
											{                            
												imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
												imgPicker.mediaTypes = mediaTypes;
													  
												[self presentModalViewController:imgPicker animated:YES];
											}								  
	
	
	UIImagePickerController * pickerController= [[UIImagePickerController alloc] init];
	pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self presentModalViewController:pickerController animated:YES];
	[pickerController release];*/
}

-(IBAction)startCamera:(id)sender{

/*	UIImagePickerController *frontCamera=[[UIImagePickerController alloc]init];
	
	frontCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
	frontCamera.cameraDevice=UIImagePickerControllerCameraDeviceFront;
	
	if ([frontCamera.mediaTypes containsObject:(NSString*)kUTTypeVideo]) {
		
		frontCamera.cameraCaptureMode= UIImagePickerControllerCameraCaptureModeVideo;
	
	}
	else {
		
		UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Camera is not For video Recording" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertview show];
		[alertview release];
	}
	[self presentModalViewController:frontCamera animated:YES];*/
	
	
	imgPicker=[[UIImagePickerController alloc]init];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[imgPicker.view addSubview:button];
	
	NSArray* mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
	if ([mediaTypes containsObject:(NSString*)kUTTypeImage]) 
	{                            
		imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
		imgPicker.mediaTypes = mediaTypes;
		imgPicker.wantsFullScreenLayout = NO;
		[imgPicker.navigationBar setHidden:YES];
		imgPicker.showsCameraControls= NO;
		imgPicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
		
		imgPicker.delegate=self;
		
		CGFloat cameraTransformX = 0.5;
		CGFloat cameraTransformY = 0.4;
		
		imgPicker.cameraViewTransform = CGAffineTransformMakeTranslation(-100,200);

		imgPicker.cameraViewTransform = CGAffineTransformScale(imgPicker.cameraViewTransform, cameraTransformX, cameraTransformY);
	
		[self presentModalViewController:imgPicker animated:YES];
		
		
	}
	
	
}
-(void)startVideoCapturing {
		
	[imgPicker setCameraCaptureMode:UIImagePickerControllerCameraCaptureModeVideo];
	[imgPicker startVideoCapture];
	
	NSLog(@"Video capturing started");
	
}
-(void)stopVideoCapturing {
	[imgPicker stopVideoCapture];
	
	NSLog(@"Video capturing stoped");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	NSLog(@"Printing decsiption of info dictionary.......... "); 
	
	[imgPicker dismissModalViewControllerAnimated:YES];
	
	NSLog(@"%@",[info objectForKey:UIImagePickerControllerMediaURL]);

	NSData *data = [[NSData alloc]initWithContentsOfURL:[info objectForKey: UIImagePickerControllerMediaURL]];
	
	NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *dirPath=[arrayPaths objectAtIndex:0];
	NSString *filePathToSaveFile = [dirPath stringByAppendingPathComponent:@"Vid"];
	
	NSString *saveToMP4Formate=[filePathToSaveFile stringByAppendingPathExtension:@"mp4"];
	
	NSLog(@"vid saved at %@",saveToMP4Formate);
	
	[data writeToFile:saveToMP4Formate atomically:YES];
	
	// NSString *tempFilePath =  [[info objectForKey: UIImagePickerControllerMediaURL] path];
	//UIAlertView *saved=[[[UIAlertView alloc]initWithTitle:nil message:@"File Saved to Documents" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil]autorelease];
	// [self.view addSubview:saved];
	//[saved show];
	
/*	if ( UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(tempFilePath) ) 
	{ 
		UISaveVideoAtPathToSavedPhotosAlbum( tempFilePath, self, 
											@selector(video: didFinishSavingWithError:contextInfo: ) , tempFilePath); 
	}
 */

}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
	
	
	UIAlertView *errorMessage = [[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

	[errorMessage show];
	[errorMessage release];
	
}

-(void)playVideo {

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectryPath = [paths objectAtIndex:0];
	
	NSString *videoFile = [NSString stringWithFormat:@"%@/Vid.mp4",documentDirectryPath];
	NSLog(@"Playing From .....%@",videoFile);
	
	MoviePlayerParentViewController* movieplayer = [[MoviePlayerParentViewController alloc]initWithPath:videoFile];
	[movieplayer readyPlayer];
	[self presentModalViewController:movieplayer animated:YES];
	[movieplayer release];

}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[imgPicker release];
	//[frontCamera release];
    [super dealloc];
}

@end
