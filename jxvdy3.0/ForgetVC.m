//
//  ForgetVC.m
//  JXVDY_iPhone
//
//  Created by jxmm on 14/12/31.
//  Copyright (c) 2014年 jinxiang. All rights reserved.
//

#import "ForgetVC.h"
#import "CustomPopNavigation.h"
#import "SVProgressHUD.h"

@interface ForgetVC ()

@end

@implementation ForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CustomPopNavigation* navBar=[[CustomPopNavigation alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width,IOS7?64:44) title:@"忘记密码"];
    navBar.backPop=^(){
        
        [self  dismissViewControllerAnimated:YES completion:nil];
    };
    [self.view addSubview:navBar];
    
    
    UIWebView* webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, IOS7?64:44, kScreenSize.width, CGRectGetHeight(self.view.frame)-(IOS7?64:44))];
    webView.userInteractionEnabled=YES;
    webView.backgroundColor=[UIColor whiteColor];
    webView.delegate=self;
    [webView setOpaque:NO];
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];
    
    NSURLRequest* request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.jxvdy.com/my/forgetpwd"]];
    [webView loadRequest:request];
    [SVProgressHUD show];
}


#pragma mark-

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
