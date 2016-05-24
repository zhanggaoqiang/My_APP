//
//  CustomPopNavigation.h
//  JXiPhoneApp
//
//  Created by Li JinLiang on 14-7-21.
//  Copyright (c) 2014年 Jinxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPopNavigation : UIView

@property (nonatomic,strong)UILabel *tilteLabel;
@property (nonatomic,copy)void (^ backPop)();


- (id)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
