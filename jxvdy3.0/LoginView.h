//
//  LoginView.h
//  IphoneApp
//
//  Created by jxmm on 15/11/20.
//  Copyright © 2015年 jinxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property(nonatomic,strong)void (^btnClick)(int);

-(id)initWithFrame:(CGRect)frame btnClick:(void(^)(int))click;

@property(nonatomic,strong)UITextField *username;
@property(nonatomic,strong)UITextField *password;
@property(nonatomic,strong)UITextField *email;
@end
