//
//  UsuallyUseViewController.m
//  养车坊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "UsuallyUseViewController.h"

#define kScreenSize [UIScreen mainScreen].bounds.size
#define kUrl @"http://shop.chediandian.com/home/more?st=android&token=&t=1438693270064&t2=&ver=3.8.3&fromType=0&ap=0"

@interface UsuallyUseViewController ()

@end

@implementation UsuallyUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    [self creatWebView];
   
}

-(void)creatWebView {
    
    
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 300)];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:kUrl]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    
    
    
    
    
    
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
