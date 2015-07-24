//
//  FrontCameraAppDelegate.h
//  FrontCamera
//
//  Created by Bipin Gohel on 04/11/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FrontCameraViewController;

@interface FrontCameraAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FrontCameraViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FrontCameraViewController *viewController;

@end

