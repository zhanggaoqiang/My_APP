//
//  AccountSettingViewController.h
//  choutixiaoguo
//
//  Created by jxmm on 16/3/22.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AccountSettingViewController : UIViewController

{
    AppDelegate* app;
}

@property(nonatomic,assign)int cellRow;

@property(nonatomic,copy)void(^ outLginBlock)(BOOL);



@end
