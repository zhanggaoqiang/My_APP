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
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.view.backgroundColor=[UIColor whiteColor];
    
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
        self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
        self.webView.delegate=self;
        [self.view addSubview:self.webView];
        
        NSURL* url = [NSURL URLWithString:@"http://m.51besttea.com"];//创建URL
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        [self.webView loadRequest:request];//加载
        
        [(UIScrollView *)[[self.webView subviews] objectAtIndex:0] setBounces:NO];

        
        self.activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 32.0f, 32.0f) ;
        [self.activityIndicatorView setCenter: self.view.center] ;
        [self.activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhiteLarge] ;
        [self.view addSubview : self.activityIndicatorView] ;
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)webViewDidStartLoad:(UIWebView *)webView {
    
    
    
   
     [self.activityIndicatorView startAnimating] ;

}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
       [self.activityIndicatorView stopAnimating];
    
    
        NSString *theTitle=[self.webView  stringByEvaluatingJavaScriptFromString:@"document.title"];
        NSLog(@"网页标题是:%@",theTitle);
        NSString *currentURL = [self.webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
        NSLog(@"页面的URL：%@",currentURL);
        

}




-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}


//#pragma mark webview每次加载之前都会调用这个方法
//// 如果返回NO，代表不允许加载这个请求
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    // 说明协议头是ios
//    if ([@"ios" isEqualToString:request.URL.scheme]) {
//        NSString *url = request.URL.absoluteString;
//        NSRange range = [url rangeOfString:@":"];
//        NSString *method = [request.URL.absoluteString substringFromIndex:range.location + 1];
//        
//        SEL selector = NSSelectorFromString(method);
//        
//        if ([self respondsToSelector:selector]) {
//            [self performSelector:selector];
//        }
//        
//        return NO;
//    }
//    
//    return YES;
//}
//




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
