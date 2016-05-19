//
//  SecondViewController.m
//  51besttea
//
//  Created by zgq on 16/5/18.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import "SecondViewController.h"
#import <WebKit/WebKit.h>

@interface SecondViewController ()<WKNavigationDelegate,WKUIDelegate>
@property(nonatomic,strong)WKWebView *webview;// 加载网页控件
@property(nonatomic,strong)UIView *navigationView;//导航视图
@property(nonatomic,strong)UILabel *titleLabel; //网页标题
@property(nonatomic,strong)UIButton *leftButton;//返回按钮
@property(nonatomic,strong)UIView *lineView;//分割线
@end

@implementation SecondViewController

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
    self.webview.navigationDelegate=self;
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
    
}

#pragma mark  - 懒加载
-(WKWebView *)webview
{
    if (!_webview) {
        _webview= [[WKWebView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-64)];
        _webview.allowsBackForwardNavigationGestures =YES;
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL  URLWithString:self.str]]];
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



#pragma mark - 返回方法
- (void)goback {
//    if ([self.webview canGoBack]) {
//        
//        [self.webview goBack];
//    }
    
    
    [self.navigationController  popViewControllerAnimated:YES];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
