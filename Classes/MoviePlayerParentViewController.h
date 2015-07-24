//
//  MoviePlayerParentViewController.h
//  MoviePlayerTest
//
//  Created by Bipin Gohel on 02/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface MoviePlayerParentViewController : UIViewController {
	MPMoviePlayerController *mp;
	NSURL *movieURL;
}

- (id)initWithPath:(NSString *)moviePath;
- (void)readyPlayer;

@end
