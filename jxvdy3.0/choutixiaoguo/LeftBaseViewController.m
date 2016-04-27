//
//  LeftBaseViewController.m
//  choutixiaoguo
//
//  Created by jxmm on 16/1/13.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "LeftBaseViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "CustomNavigationItem.h"
#import "RightViewController.h"
@implementation LeftBaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
//    RightViewController *rightvc=[[RightViewController alloc] init];
//    
//    
//    
//
//    aNavigationItem=[[CustomNavigationItem alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64) showPerson:YES showFind:YES title:@"微电影" rightButton:^(int  tag) {
//        
//        if (tag==100) {
//            
//          //  [self presentViewController:rightvc animated:YES completion:nil];
//            
//            [self presentViewController:rightvc animated:YES completion:nil];
//            
//            
//        }
//       
//        
//        
//        
//    }];
//    aNavigationItem.backgroundColor=[UIColor  orangeColor];
//      aNavigationItem.navDelegate = self;
//    [self.view addSubview:aNavigationItem];
//
}



#pragma mark- 自定义导航栏代理
-(void)leftDrawerPress
{
    [app.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightDrawerPress
{
    [app.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}







@end
