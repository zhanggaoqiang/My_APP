//
//  LoginViewController.m
//  choutixiaoguo
//
//  Created by jxmm on 16/3/16.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "RegisterViewController.h"
#import "ForgetVC.h"



#define loginUrl @"http://api2.jxvdy.com/member_login"

@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=GRAY_BACK;
    
    
    UIView *navigationView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 64)];
    navigationView.backgroundColor=[UIColor whiteColor];
    
    [self.view  addSubview:navigationView];

    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.selected=NO;
    button.frame=CGRectMake(0, 20, 44, 44);
    [button setTitle:@"我的" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];

    _manager=[[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    
    _username=[[UITextField alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
    _username.placeholder=@"用户名";
    
    _username.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_username];
    
    
    _password=[[UITextField alloc] initWithFrame:CGRectMake(0, 131, self.view.frame.size.width, 30)];
    _password.placeholder=@"密码";
    _password.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_password];
    
    UIButton *closeButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 20, 40, 40)];
    [closeButton  setImage:[UIImage   imageNamed:@"关闭"] forState:UIControlStateNormal];
    [closeButton  setImage:[UIImage  imageNamed:@"关闭-触发"] forState:UIControlStateSelected];
    
    [closeButton  addTarget:self action:@selector(closeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [navigationView  addSubview:closeButton];
    
    
    
    
    UIButton*loginButton=[[UIButton alloc] initWithFrame:CGRectMake(0,200,kScreenSize.width, 30)];
    [loginButton  setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    loginButton.backgroundColor=[UIColor whiteColor];
    [loginButton   addTarget:self action:@selector(LoginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    
    
    
    
    UIButton*registerButton=[[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width-50,20, 50, 50)];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton  setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font=[UIFont  systemFontOfSize:13];
    [registerButton   addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [navigationView addSubview:registerButton];
    
    
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(kScreenSize.width/2-25, 30, 50, 20)];
    label.text=@"登录";
    label.textColor=[UIColor blackColor];
    
    label.font=[UIFont systemFontOfSize:18];
    [navigationView addSubview:label];
    
    
    UIButton *forgetCode=[[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width-60, 164, 60, 20)];
    [forgetCode  setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetCode  setTitleColor:[UIColor  blackColor] forState:UIControlStateNormal];
    forgetCode.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:forgetCode];
    [forgetCode addTarget:self action:@selector(forgetpage:) forControlEvents:UIControlEventTouchUpInside];

    [self creatThirdLogin];

    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_username  resignFirstResponder];
    [_password  resignFirstResponder];
}


-(void)closeBtn:(UIButton *)sender {
        [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)forgetpage:(UIButton *)sender {
    
    ForgetVC *vc=[[ForgetVC alloc] init];
    
    [self  presentViewController:vc animated:YES completion:nil];
    
}


-(void)registerClick:(UIButton *)sender {
    
    RegisterViewController *regi=[[RegisterViewController alloc] init];
    [self presentViewController:regi animated:YES completion:nil];
    
}
-(void)LoginClick:(UIButton *)login {
    NSDictionary *dict=@{
                         @"name":self.username.text,
                         @"pwd":self.password.text,
                         
                         };
    
    NSString *urll=[loginUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_manager GET:urll parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id  arr2=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
         NSString *loginReturnCode=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        if ([arr2 isKindOfClass:[NSArray class]] ) {
           
            [[NSUserDefaults standardUserDefaults]   setObject:arr2[1] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]   setObject:arr2[0] forKey:@"id"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
           
            NSDictionary *dict1=@{
                                 @"id":[[NSUserDefaults standardUserDefaults] objectForKey:@"id"],
                                 @"token":[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]
                                 };
            
            [_manager   GET:MEMBER_INFOR parameters:dict1 success:^(AFHTTPRequestOperation *  operation, id responseObject) {
                
                NSLog(@"返回的arr2是多少%@",arr2);
                id arr1=  [NSJSONSerialization  JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                [[NSUserDefaults standardUserDefaults] setObject:arr1[@"face"] forKey:@"image"];
                [[NSUserDefaults standardUserDefaults] setObject:arr1[@"text"] forKey:@"text"];
                [[NSUserDefaults standardUserDefaults] setObject:arr1[@"fans"] forKey:@"fans"];
                [[NSUserDefaults standardUserDefaults] setObject:arr1[@"follow"] forKey:@"follow"];
                [[NSUserDefaults standardUserDefaults] setObject:arr1[@"nick"] forKey:@"nick"];
                [[NSUserDefaults standardUserDefaults] setObject:arr1[@"profile"] forKey:@"profile"];
                
                
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                
            }];
            
             NSLog(@"返回的内容:%@",arr2);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
      else  {
          
          if([self.username.text isEqualToString:@""]||[self.password.text  isEqualToString:@""])
          {
              [self  showAlertViewWithTitle:@"警告" message:@"用户名或者密码为空"];
          }
          
          else  if([loginReturnCode   isEqualToString:@"-1"])
          {
              [self  showAlertViewWithTitle:@"警告" message:@"参数错误"];
          }
          else   if([loginReturnCode   isEqualToString:@"-2"])
          {
              [self  showAlertViewWithTitle:@"警告" message:@"用户不存在"];
          }
          else  if([loginReturnCode   isEqualToString:@"-3"])
          {
              [self  showAlertViewWithTitle:@"警告" message:@"封号"];
          }
          else if([loginReturnCode   isEqualToString:@"-4"])
          {
              [self  showAlertViewWithTitle:@"警告" message:@"用户加密方式升级失败"];
          }
          else  if([loginReturnCode   isEqualToString:@"-5"])
          {
              [self  showAlertViewWithTitle:@"警告" message:@"用户名或者密码错误"];
          }
          
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
 }

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)creatThirdLogin {
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(kScreenSize.width/2-50, kScreenSize.height/2, 100, 20)];
    label.text=@"第三方登录";
    label.textAlignment=NSTextAlignmentCenter;
    [self.view  addSubview:label];
    
    NSArray *imageArr=@[@"新浪微博",@"腾讯微博",@"腾讯QQ"];
    NSArray *imageSelectedArr=@[@"新浪微博-触发",@"腾讯微博-触发",@"腾讯QQ-触发"];
    
    for (NSInteger i=0; i<3; i++) {
        UIButton *button=[UIButton new];
        
        [button  setImage:[UIImage   imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [button  setImage:[UIImage   imageNamed:imageSelectedArr[i]] forState:UIControlStateSelected];
        [self.view  addSubview:button];
        
        UILabel *textlabel=[UILabel new];
        textlabel.text=imageArr[i];
        textlabel.textColor=[UIColor blackColor];
        textlabel.font=[UIFont  systemFontOfSize:12];
        [self.view  addSubview:textlabel];
        textlabel.textAlignment=NSTextAlignmentCenter;
        [button   mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.view.mas_left).offset((i+1)*kScreenSize.width/5);
            make.width.mas_equalTo(kScreenSize.width/6);
            make.top.mas_equalTo(label.mas_bottom).offset(20);
            make.height.mas_equalTo(kScreenSize.width/6);
         }];
        
        [textlabel   mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.left.mas_equalTo(self.view.mas_left).offset((i+1)*kScreenSize.width/5);
            make.width.mas_equalTo(kScreenSize.width/6);
            make.top.mas_equalTo(label.mas_bottom).offset(20+kScreenSize.width/6);
            make.height.mas_equalTo(kScreenSize.width/6);
        }];
    }
}


-(void)backbtn {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
