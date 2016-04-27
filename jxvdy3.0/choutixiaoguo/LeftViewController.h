//
//  LeftViewController.h
//  choutixiaoguo
//
//  Created by jxmm on 16/1/13.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class  CenterViewController;
@interface LeftViewController : UIViewController
{
    UIView* scrollView;
    CenterViewController* centerVC;
    AppDelegate* app;
}
@property(nonatomic,strong)NSMutableArray* btnArray;
@property(nonatomic,strong)NSMutableArray *optionArray;

@property(nonatomic,strong)UIButton* currentBtn;
@property(nonatomic,strong)UIButton *currentOptionBtn;

@end
