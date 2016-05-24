//
//  ShareView.m
//  JXiPhoneApp
//
//  Created by jxmm on 14-8-20.
//  Copyright (c) 2014年 Jinxiang. All rights reserved.
//

#import "ShareView.h"
#import "Masonry.h"


@implementation ShareView

- (id)initWithFrame:(CGRect)frame  shareItem:(void(^)(int))shareIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        _shareBtn=shareIndex;
        UIView* btnView=[[UIView alloc] initWithFrame:CGRectMake(5, 0, kScreenSize.width-10, 200)];
        btnView.backgroundColor=POP_COLOR;
        [btnView.layer setCornerRadius:3];
        [self addSubview:btnView];
        
        for (int i=0; i<5; i++) {
            int line=i%3;
            int row=i/3;
            UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
           // button.frame=CGRectMake(37+(51+40)*line, 14+(51+42)*row, 51, 51);
            button.tag=i+1;
            [button setImage:[UIImage imageNamed:@[@"新浪微博",@"腾讯微博",@"微信",@"微信朋友圈",@"金象动态"][i]] forState:UIControlStateNormal];
            
            [button setImage:[UIImage imageNamed:@[@"新浪微博-触发",@"腾讯微博-触发",@"微信-触发",@"微信朋友圈-触发",@"金象动态-触发"][i]] forState:UIControlStateHighlighted];
            
         
          
              [btnView addSubview:button];
            
            [button   mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_left).offset(50+line*(self.frame.size.width-40)/3);
                make.width.mas_equalTo((self.frame.size.width-40)/9);
                make.top.mas_equalTo(row*(self.frame.size.width-40)/6+50);
                make.height.mas_equalTo(self.frame.size.height/6);
                
            }];
            
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
          
                  
            UILabel *label=[UILabel new];
            label.textColor=GRAY_TITLE;
            label.font=[UIFont systemFontOfSize:12];
            label.backgroundColor=[UIColor clearColor];
            if (i==3) {
                label.frame=CGRectMake(32, 73+(14+152-73)*row, 61, 16);
            }
            label.text=@[@"新浪微博",@"腾讯微博",@"微信好友",@"微信朋友圈",@"金象动态"][i];
            [btnView addSubview:label];
            
            [label  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_left).offset(50+line*(self.frame.size.width-40)/3);
                make.width.mas_equalTo((self.frame.size.width-40)/6);
                make.top.mas_equalTo(row*(self.frame.size.width-40)/6+self.frame.size.height/3);
                make.height.mas_equalTo(self.frame.size.height/6);
                
                
            }];
    }
        
        UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=POP_COLOR;
        button.tag=6;
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:ORANGE_COLOR forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:19];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button.layer setCornerRadius:3];
        [self addSubview:button];
        
        
        [button  mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.mas_left).offset(5);
            make.width.mas_equalTo(kScreenSize.width-10);
            make.top.mas_equalTo(btnView.mas_bottom).offset(6);
            make.height.mas_equalTo(44);
            
            
        }];
    }
    return self;
}
-(void)btnClick:(UIButton*)sender
{
    _shareBtn((int)sender.tag);
}


@end
