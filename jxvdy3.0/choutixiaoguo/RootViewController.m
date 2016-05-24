//
//  RootViewController.m
//  choutixiaoguo
//
//  Created by jxmm on 16/1/13.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "RootViewController.h"

@interface  RootViewController()

@property (nonatomic, assign) UIInterfaceOrientationMask interfaceOrientationMask;

@end


@implementation RootViewController

@synthesize interfaceOrientationMask= _interfaceOrientationMask;

- (void)changeSupportedInterfaceOrientations:(UIInterfaceOrientationMask)interfaceOrientation
{
    _interfaceOrientationMask = interfaceOrientation;
}

-(BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return self.topViewController.supportedInterfaceOrientations;
}


@end
