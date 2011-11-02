//
//  GooglemapDemoAppDelegate.h
//  GooglemapDemo
//
//  Created by Eric Lin on 2010/7/22.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GooglemapDemoViewController;

@interface GooglemapDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UIViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *viewController;

@end

