//
//  LeftBaseViewController.h
//  choutixiaoguo

//  Created by jxmm on 16/1/13.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationItem.h"
#import "AppDelegate.h"

@interface LeftBaseViewController : UIViewController<CustomNavigationItemDelegate>

{
    AppDelegate* app;
    CustomNavigationItem *aNavigationItem;
}

@end
