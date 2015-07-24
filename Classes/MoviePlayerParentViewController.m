//
//  MoviePlayerParentViewController.m
//  MoviePlayerTest
//
//  Created by Bipin Gohel on 02/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MoviePlayerParentViewController.h"
//#import "UPNPAppDelegate.h"//#import "FrameManager.h"


@implementation MoviePlayerParentViewController
/*---------------------------------------------------------------------------
 * 
 *--------------------------------------------------------------------------*/
- (id)initWithPath:(NSString *)moviePath
{
	// Initialize and create movie URL
	if (self = [super init])
	{		
		if([moviePath hasPrefix:@"http://"])
		{
			movieURL = [NSURL URLWithString:moviePath];
		}
		else 
		{
			movieURL = [NSURL fileURLWithPath:moviePath];
		}		
		[movieURL retain];
	}
	return self;
}

/*---------------------------------------------------------------------------
 * For 3.2 and 4.x devices
 * For 3.1.x devices see moviePreloadDidFinish:
 *--------------------------------------------------------------------------*/
- (void) moviePlayerLoadStateChanged:(NSNotification*)notification 
{
	// Unless state is unknown, start playback
	if ([mp loadState] != MPMovieLoadStateUnknown)
	{
		// Remove observer
		[[NSNotificationCenter 	defaultCenter] 
		 removeObserver:self
		 name:MPMoviePlayerLoadStateDidChangeNotification 
		 object:nil];
		
		// When tapping movie, status bar will appear, it shows up
		// in portrait mode by default. Set orientation to landscape
//		if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
//			[[self view] setBounds:CGRectMake(0, 0, 768, 1024)];
//			//[[self view] setCenter:CGPointMake(160, 240)];
//			
//			[[mp view] setFrame:CGRectMake(0, 0, 768, 1024)];
//		}	  else {
//			[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
//			
//			// Rotate the view for landscape playback
//			[[self view] setBounds:CGRectMake(0, 0, 480, 320)];
//			[[self view] setCenter:CGPointMake(160, 240)];
//			[[self view] setTransform:CGAffineTransformMakeRotation(M_PI / 2)]; 
//			
//			// Set frame of movieplayer
//			[[mp view] setFrame:CGRectMake(0, 0, 480, 320)];
//		}
		
		
		// Add movie player as subview
		float version = [[[UIDevice currentDevice] systemVersion] floatValue];
		if(version >= 3.2)
		{
			CGRect newFrame = CGRectMake(0, 0, 320, 480);
			mp.view.frame = newFrame;
			[[self view] addSubview:[mp view]];   
		}
		else 
		{
			self.view = mp.view;
		}		
		// Play the movie
		[mp play];
	}
}

/*---------------------------------------------------------------------------
 * For 3.1.x devices
 * For 3.2 and 4.x see moviePlayerLoadStateChanged: 
 *--------------------------------------------------------------------------*/
- (void) moviePreloadDidFinish:(NSNotification*)notification 
{
	// Remove observer
	[[NSNotificationCenter 	defaultCenter] 
	 removeObserver:self
	 name:MPMoviePlayerContentPreloadDidFinishNotification
	 object:nil];
	
	// Play the movie
 	[mp play];
}

/*---------------------------------------------------------------------------
 * 
 *--------------------------------------------------------------------------*/
- (void) moviePlayBackDidFinish:(NSNotification*)notification 
{    
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
	
 	// Remove observer
	[[NSNotificationCenter 	defaultCenter] 
	 removeObserver:self
	 name:MPMoviePlayerPlaybackDidFinishNotification 
	 object:nil];
	//[self.view removeFromSuperview];
	[self dismissModalViewControllerAnimated:YES];
}

/*---------------------------------------------------------------------------
 *
 *--------------------------------------------------------------------------*/
- (void) readyPlayer
{
	NSLog(@"ReadyPlayer");
 	mp =  [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
	
	if ([mp respondsToSelector:@selector(loadState)]) 
	{
		// Set movie player layout
		[mp setControlStyle:MPMovieControlStyleFullscreen];
		[mp setFullscreen:YES];
		
		// May help to reduce latency
		[mp prepareToPlay];
		
		// Register that the load state changed (movie is ready)
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(moviePlayerLoadStateChanged:) 
													 name:MPMoviePlayerLoadStateDidChangeNotification 
												   object:nil];
	}  
	else
	{
		// Register to receive a notification when the movie is in memory and ready to play.
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(moviePreloadDidFinish:) 
													 name:MPMoviePlayerContentPreloadDidFinishNotification 
												   object:nil];
	}
	
	// Register to receive a notification when the movie has finished playing. 
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePlayBackDidFinish:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:nil];
}

/*---------------------------------------------------------------------------
 * 
 *--------------------------------------------------------------------------*/
- (void) loadView
{
	[self setView:[[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease]];
	self.view.autoresizesSubviews = YES;
	[[self view] setBackgroundColor:[UIColor blackColor]];
}

/*---------------------------------------------------------------------------
 *  
 *--------------------------------------------------------------------------*/
- (void)dealloc 
{
	[mp release];
	[movieURL release];
	[super dealloc];
}

#pragma mark -
#pragma mark orientation


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	/*
	UPNPAppDelegate *upnpAppDel = (UPNPAppDelegate *)[[UIApplication sharedApplication] delegate];
	upnpAppDel.currentOrientationType=interfaceOrientation;*/
	return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	/*float version = [[[UIDevice currentDevice] systemVersion] floatValue];
	if(version >= 3.2)
	{
		CGRect newFrame = CGRectMake(0, 0, 320, 480);
	//	newFrame.origin.x = mp.view.frame.origin.x;
	//	newFrame.origin.y = mp.view.frame.origin.y;
		mp.view.frame = newFrame;
		//self.view.frame = newFrame;
	//	mp.view.frame = [FrameManager getFrameForComponent:@"MoviePlayer"];
	 }*/
}


@end
