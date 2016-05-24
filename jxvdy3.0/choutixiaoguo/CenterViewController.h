//
//  CenterViewController.h
//  choutixiaoguo
//
//  Created by jxmm on 16/1/13.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface CenterViewController : UIViewController
{
    AppDelegate* app;
}
@property (nonatomic,assign) int     index;
@property (nonatomic,strong) id currentVC;
@property (nonatomic,strong) id targetVC;

@end
