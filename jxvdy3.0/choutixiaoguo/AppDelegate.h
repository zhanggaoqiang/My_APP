//
//  AppDelegate.h
//  choutixiaoguo
//
//  Created by jxmm on 16/1/13.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "MMDrawerController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MMDrawerController* drawerController;

@property (strong, nonatomic) RootViewController* nav2;
@property (strong, nonatomic) RootViewController* nav3;


@property (strong, nonatomic) NSString* token;

@end

