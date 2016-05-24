//
//  DetailExploreControllerViewController.m
//  Timer
//
//  Created by qianfeng on 15/8/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailExploreControllerViewController.h"



@interface DetailExploreControllerViewController ()


@end

@implementation DetailExploreControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor redColor];
    
    
    UIWebView *webview=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height)];
    
    webview.scalesPageToFit=YES;
    
    
    NSURLRequest *request =[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat: WebViewURL ,self.strid]]];
     [webview  loadRequest:request];
    [self.view addSubview:webview];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}


@end
