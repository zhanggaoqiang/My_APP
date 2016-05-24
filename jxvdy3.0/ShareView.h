//
//  ShareView.h
//  JXiPhoneApp
//
//  Created by jxmm on 14-8-20.
//  Copyright (c) 2014年 Jinxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView

@property(nonatomic,copy)void (^ shareBtn)(int);

- (id)initWithFrame:(CGRect)frame  shareItem:(void(^)(int))shareIndex;
@end
