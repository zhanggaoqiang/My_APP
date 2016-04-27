//
//  CustomPopNavigation.m
//  JXiPhoneApp
//
//  Created by Li JinLiang on 14-7-21.
//  Copyright (c) 2014年 Jinxiang. All rights reserved.
//

#import "CustomPopNavigation.h"

@implementation CustomPopNavigation

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor=POP_COLOR;
        UIImageView *bgImageView = [[UIImageView alloc] init];
        [bgImageView setBackgroundColor:POP_COLOR];
        [self addSubview:bgImageView];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.tag=20;
        [backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"返回High"] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(PopViewController:) forControlEvents:UIControlEventTouchUpInside];
        backBtn.backgroundColor=[UIColor clearColor];
        [self addSubview:backBtn];
        
        _tilteLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, IOS7?32:12, 180, 22)];
        _tilteLabel.tag=10;
        _tilteLabel.font=[UIFont systemFontOfSize:20];
        _tilteLabel.textColor=BLACK_COLOR;
        _tilteLabel.textAlignment = NSTextAlignmentCenter;
        _tilteLabel.text=title;
        _tilteLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:_tilteLabel];
        
        [bgImageView setFrame:CGRectMake(0, 0, 320, IOS7?64:44)];
        [backBtn setFrame:CGRectMake(0, IOS7?20:0, 44, 44)];
        
        UIView* line=[[UIView alloc] initWithFrame:CGRectMake(0, IOS7?63.5:43.5, 320, .5)];
        line.backgroundColor=GRAY_LINE;
        [self addSubview:line];
    }
    return self;
}

- (void)PopViewController:(UIButton*)sender
{
    _backPop();
    
}

 

@end
