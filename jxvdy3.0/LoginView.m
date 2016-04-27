//
//  LoginView.m
//  IphoneApp
//
//  Created by jxmm on 15/11/20.
//  Copyright © 2015年 jinxiang. All rights reserved.
//

#import "LoginView.h"
#import "AFNetworking.h"
#define lurl @"http://api2.jxvdy.com/member_login"
@interface LoginView()
{
    AFHTTPRequestOperationManager *_manager;
//    UITextField *_username;
//     UITextField *_password;
//     UITextField *_email;
//    
}
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@end

@implementation LoginView

-(id)initWithFrame:(CGRect)frame {
    
    self=[super  initWithFrame:frame];
    if (self) {
        _username=[[UITextField alloc] initWithFrame:CGRectMake(50, 50, self.frame.size.width-100, 30)];
        _username.placeholder=@"用户名";
        _username.backgroundColor=[UIColor whiteColor];
        [self addSubview:_username];
        
        
        _password=[[UITextField alloc] initWithFrame:CGRectMake(50, 100, self.frame.size.width-100, 30)];
        _password.placeholder=@"密码";
         _password.backgroundColor=[UIColor whiteColor];
        [self addSubview:_password];

//         _email   =[[UITextField alloc] initWithFrame:CGRectMake(50, 150, self.frame.size.width-100, 30)];
//        _email.placeholder=@"邮箱";
//        _email.backgroundColor=[UIColor whiteColor];
//        [self addSubview:_email];
//               
}
    
    
    return self;
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
