//
//  RegisterViewController.m
//  choutixiaoguo
//
//  Created by jxmm on 16/3/22.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFNetworking.h"

#define registerUrl @"http://api2.jxvdy.com/member_regist"

@interface RegisterViewController ()

@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=GRAY_BACK;
    UIView *navigationView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 64)];
    navigationView.backgroundColor=[UIColor whiteColor];
    
    [self.view  addSubview:navigationView];
    
    
    
    
    
    
    
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
    
    _email   =[[UITextField alloc] initWithFrame:CGRectMake(0, 162, self.view.frame.size.width, 30)];
    _email.placeholder=@"邮箱";
    _email.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_email];
    
    
    UIButton*registerButton=[[UIButton alloc] initWithFrame:CGRectMake(0,200, kScreenSize.width, 30)];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton   addTarget:self action:@selector(RegisterClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    
    
    UIButton*loginButton=[[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width-50,20,44, 44)];
    [loginButton  setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    loginButton.backgroundColor=[UIColor whiteColor];
    [loginButton   addTarget:self action:@selector(LoginClick:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:loginButton];
    // Do any additional setup after loading the view.
}


-(void)LoginClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)RegisterClick:(UIButton *)button {
    
    
    NSDictionary *dict=@{
                         @"name":self.username.text,
                         @"pwd":self.password.text,
                         @"email":self.email.text
                         };
    
    NSString *url=[registerUrl  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_manager GET  :url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id  arrId=[NSJSONSerialization  JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responseObject);
        if ([arrId  isKindOfClass:[NSArray class]] ) {
            
            [self showAlertViewWithTitle:@"恭喜" message:@"注册成功"];
            
            NSLog(@"注册时的token:%@",arrId[1]);
            
            
            
            [self  dismissViewControllerAnimated:YES completion:nil];
        }
        
        else { if ([self.username.text  isEqualToString:@""]||[self.password.text  isEqualToString:@""]||[self.email.text  isEqualToString:@""]) {
            
            [self showAlertViewWithTitle:@"恭喜" message:@"用户名或者密码或者邮箱不能为空"];
            
        }
            
        else{
            [self registerErrorDealWith:str];
        }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"注册失败");
    }];
}
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}



-(void)registerErrorDealWith:(NSString *)str {
    if ([str  isEqualToString: @"-1"]) {
        [self  showAlertViewWithTitle:@"警告" message:@"密码长度至少六位"];
    }
    else if ([str isEqualToString:@"-101"]) {
        [self showAlertViewWithTitle:@"警告" message:@"ID只能是数字"];
    }
    else if([str  isEqualToString:@"-102"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"名称不能为空"];
        
    }
    else if([str  isEqualToString:@"-103"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"名称不能超过40个字符"];
        
    }
    else if([str  isEqualToString:@"-104"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"名称仅限数字和字母"];
        
    }
    else if([str  isEqualToString:@"-105"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"用户名已经存在"];
        
    }
    else if([str  isEqualToString:@"-106"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"昵称转化错误"];
        
    }
    else if([str  isEqualToString:@"-107"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"名称不能为空"];
    }
    else if([str  isEqualToString:@"-108"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"昵称超过长度"];
    }
    else if([str  isEqualToString:@"-109"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"邮箱不能为空"];
    }
    else if([str  isEqualToString:@"-110"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"邮箱格式不正确"];
    }
    else if([str  isEqualToString:@"-111"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"密码不能为空"];
    }
    else if([str  isEqualToString:@"-112"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"密码加密长度错误"];
    }
    else if([str  isEqualToString:@"-113"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"名称不能为空"];
    }
    else if([str  isEqualToString:@"-114"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"名称不能为空"];
    }
    else if([str  isEqualToString:@"-115"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"名称不能为空"];
    }
    else if([str  isEqualToString:@"-116"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"无效的状态值"];
    }
    else if([str  isEqualToString:@"-117"]   ){
        [self showAlertViewWithTitle:@"警告" message:@"邮箱已经存在"];
    }
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
