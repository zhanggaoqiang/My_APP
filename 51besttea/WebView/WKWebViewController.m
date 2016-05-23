//
//  ViewController.m
//  WebView
//
//  Created by zgq on 16/5/3.
//  Copyright © 2016年 zgq. All rights reserved.

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>


@interface WKWebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property(nonatomic,strong)WKWebView *webview;// 加载网页控件
@property(nonatomic,strong)UIView *navigationView;//导航视图
@property(nonatomic,strong)UILabel *titleLabel; //网页标题
@property(nonatomic,strong)UIButton *leftButton;//返回按钮
@property(nonatomic,strong)UIView *lineView;//分割线
@property(nonatomic,strong)UIActivityIndicatorView *activityView;//网络指示器

@end
@implementation WKWebViewController

#pragma mark  - 生命周期函数
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self  setUserAgent];
    [self.view  addSubview:self.webview];
    [self.view addSubview:self.navigationView];
    [self.navigationView  addSubview:self.titleLabel];
    [self.navigationView addSubview:self.leftButton ];
    [ self.view addSubview:self.lineView ];

    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
 }

#pragma mark - 配置用户代理user_Agent

-(void)setUserAgent {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero] ;
    NSString *Agent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    //add my info to the new agent
    NSString *newAgent = nil;
    newAgent = [Agent stringByAppendingString:@" 51bestteaApp"];
    //regist the new agent
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent",nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    NSLog(@"userAgent是:%@",dictionnary);
    
}

#pragma mark  - 懒加载
-(WKWebView *)webview
{
    if (!_webview) {
         _webview= [[WKWebView alloc] initWithFrame:CGRectMake(0,65, self.view.frame.size.width, self.view.frame.size.height-64)];
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL  URLWithString:@"http://m.51besttea.com"]]];
        _webview.backgroundColor=[UIColor whiteColor];
     
       
        _webview.navigationDelegate=self;
        
        [_webview addObserver:self  forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];

    }
    return  _webview;
}

-(UIView *)navigationView
{
    if (!_navigationView) {
        _navigationView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
        _navigationView.backgroundColor=[UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
     
    }
    return _navigationView;
    
    
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(45, 20,self.view.frame.size.width-90 , 40)];
        _titleLabel.textColor=[UIColor blackColor];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
     

    }
    return _titleLabel;
}


-(UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton =[[UIButton alloc] initWithFrame:CGRectMake(0, 20, 45, 40)];
        
        [ _leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _leftButton.hidden=YES;
        [ _leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_leftButton  setImage:[UIImage imageNamed:@"返回High"] forState:UIControlStateSelected];
    
        [_leftButton addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];

    }
    return _leftButton;
}


-(UIView *)lineView
{
    if (!_lineView) {
        
       _lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 1)];
       _lineView.backgroundColor=[UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1];
    
    }
    return _lineView;
 }

-(UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
          _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
        //放到中间
        
        //默认必须转动 才显示
     
        //改变 转动的颜色
        [_activityView  startAnimating];
        _activityView.color = [UIColor blackColor];
       
        
    }
    return _activityView;
}



#pragma mark - 返回方法
- (void)goback {
    if ([self.webview canGoBack]) {

         [self.webview goBack];
        
    }
}

#pragma mark - 观察者方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath  isEqualToString:@"title"]) {
 
        if ([self.webview.title  isEqualToString:@"51好茶网-一杯干净的好茶"]) {
            self.leftButton.hidden=YES;
            self.titleLabel.text=self.webview.title;
            
        }else {
         
            self.leftButton.hidden=NO;
            self.titleLabel.text =self.webview.title;
       }
        

    }
}
#pragma mark - 代理方法
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    
   
    
    
    
    
}


-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
  
    [_activityView startAnimating];
    [self.webview addSubview:_activityView];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
   
  
    [_activityView  stopAnimating];
}




@end
