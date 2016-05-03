//
//  ViewController.m
//  WebView
//
//  Created by zgq on 16/5/3.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"


@interface ViewController ()<UIWebViewDelegate>
{

UIActivityIndicatorView *activityIndicatorView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
     AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    if (mgr)
    {
        CGRect bounds = [[UIScreen mainScreen]applicationFrame];
        UIWebView* webView = [[UIWebView alloc]initWithFrame:bounds];
        webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
        webView.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
        webView.delegate=self;
        [self.view addSubview:webView];
        
        NSURL* url = [NSURL URLWithString:@"http://m.51besttea.com"];//创建URL
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        [webView loadRequest:request];//加载
        
        [(UIScrollView *)[[webView subviews] objectAtIndex:0] setBounces:NO];

        
        activityIndicatorView = [[UIActivityIndicatorView alloc]
                                 initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
        [activityIndicatorView setCenter: self.view.center] ;
        [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhiteLarge] ;
        [self.view addSubview : activityIndicatorView] ;
        
    }
    else
    {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"完不成作业要做俯卧撑" preferredStyle:UIAlertControllerStyleAlert];
      
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"取消按钮被点击");
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"确定按钮被点击");
        }]];

        
        
        
    }
    

       
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)webViewDidStartLoad:(UIWebView *)webView {
 
     [activityIndicatorView startAnimating] ;

}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
       [activityIndicatorView stopAnimating];
     
}




-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
