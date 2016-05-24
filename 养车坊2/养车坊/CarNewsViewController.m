//
//  CarNewsViewController.m
//  养车坊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CarNewsViewController.h"


#define kScreenSize [UIScreen mainScreen].bounds.size

@interface CarNewsViewController ()
{

    UIWebView *_webView;
    
}

@end

@implementation CarNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self creatWebview];
   
  }

-(void)creatWebview {
    
    _webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height)];
        NSString *urlString =self.str;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
    
    
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
