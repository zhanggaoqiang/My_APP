//
//  ViewController.m
//  WebView
//
//  Created by zgq on 16/5/3.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import <WebKit/WebKit.h>


@interface ViewController ()<UIWebViewDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.view.backgroundColor=[UIColor whiteColor];
    WKWebView *webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];

    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL  URLWithString:@"http://m.51besttea.com"]]];
    [self.view  addSubview:webview];
  }






@end
