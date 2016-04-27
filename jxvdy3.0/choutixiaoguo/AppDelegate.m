//
//  AppDelegate.m
//  choutixiaoguo
//
//  Created by jxmm on 16/1/13.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "CenterViewController.h"
#import "RightViewController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    CGRect rect=[[UIScreen   mainScreen] bounds];
    CGSize  size=rect.size;
    CGFloat draweWidth=size.width*2/3;

    
    LeftViewController *leftDrawer=[[LeftViewController alloc]init];
    CenterViewController *center=[[CenterViewController alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:center];
    nav.navigationBar.hidden=YES;
    
 //  RightViewController *rightDrawer=[[RightViewController alloc] init];
    
      
    MMDrawerController *drawerController=[[MMDrawerController alloc]initWithCenterViewController:nav leftDrawerViewController:leftDrawer];
    
    drawerController.shouldStretchDrawer=NO;
    self.drawerController=drawerController;
    
    
    [drawerController setMaximumLeftDrawerWidth:draweWidth];
  
    
    [drawerController  setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController  setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        if(block){
            block(drawerController, drawerSide, percentVisible);
            
        }
    }];
    
    self.window.rootViewController=drawerController;
    self.window.backgroundColor=[UIColor magentaColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
