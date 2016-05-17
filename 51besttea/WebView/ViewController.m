//
//  ViewController.m
//  WebView
//
//  Created by zgq on 16/5/3.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<UIWebViewDelegate,WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *webview;//
@property(nonatomic,strong)UIView *navigationView;//导航视图
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *leftButton;//返回按钮
@property(nonatomic,strong)UIButton *rightButton;//前进按钮
@property(nonatomic,strong)UIView *lineView;//分割线



@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSString *title1;
@property(nonatomic,strong)NSString *title2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //204,204
    
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-64)];

    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL  URLWithString:@"http://m.51besttea.com"]]];
    
    [self.webview addObserver:self  forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    
    [self.view  addSubview:self.webview];
    
    self.navigationView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    self.navigationView.backgroundColor=[UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    [self.view addSubview:self.navigationView];
    self.titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(45, 20,self.view.frame.size.width-90 , 30)];
    self.titleLabel.textColor=[UIColor blackColor];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
  //  self.titleLabel.font=[UIFont  systemFontOfSize:17];
    [self.navigationView  addSubview:self.titleLabel];
    
    
    
    self.leftButton =[[UIButton alloc] initWithFrame:CGRectMake(0, 20, 45, 40)];
  
    [ self.leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.leftButton.hidden=YES;
    [ self.leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
     [self.leftButton  setImage:[UIImage imageNamed:@"返回High"] forState:UIControlStateSelected];
    
    
    
    
     
    
    [self.navigationView addSubview:self.leftButton ];
    [self.leftButton addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    
    self.lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 1)];
    self.lineView.backgroundColor=[UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1];
   [ self.view addSubview:self.lineView ];
    
    
    
    
      
}


- (void)goback {
    if ([self.webview canGoBack]) {
        [self.webview goBack];
    }
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath  isEqualToString:@"title"]) {
        if ([self.webview.title  isEqualToString:@"51好茶网-一杯干净的好茶"]) {
            self.leftButton.hidden=YES;
            self.titleLabel.text=self.webview.title;
            
        }else {
           // NSString *str =[NSString stringWithString:self.webview.title];
         
            self.leftButton.hidden=NO;
            self.titleLabel.text =self.webview.title;
            
//            self.titleArr =[NSArray array];
//            
//             self.titleArr =[str componentsSeparatedByString:@"-" ];
//            
//            for (NSInteger i=0; i<self.titleArr.count; i++) {
//                NSLog(@"%@",self.titleArr[i]);
//               
//                if (i==1) {
//                    self.title1 =self.titleArr[1];
//                    NSLog(@"title1是：%@",self.title1);
//                    
//                }
//                if (i==2) {
//                
//                    [self.title2 = self.titleArr[2]stringByAppendingString:self.title1];
//                    NSLog(@"title2是：%@",self.title2);
//                    self.titleLabel.text=self.title1;
//                    
//                }
//                
//                
//                
//                
//                
//            }
//         
       }
    }
}




           
-(void)webViewDidStartLoad:(UIWebView *)webView {
    
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView {


}










@end
