//
//  NewsAndInformationViewController.m
//  LOL盒子
//
//  Created by qianfeng on 15/8/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewsAndInformationViewController.h"
#import "BaseViewController.h"
#import "NewsInforViewController.h"
#import "VideoViewController.h"
#import "HeroViewController.h"
#import "ComViewController.h"
#import "MoreViewController.h"
@interface NewsAndInformationViewController ()

@end

@implementation NewsAndInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViewControllers];
    
  
}


- (void)creatViewControllers {
    NSArray *titles = @[@"资讯",@"视频",@"英雄",@"社区",@"更多"];
    NSArray *classNames=@[@"NewsInforViewController",@"VideoViewController",@"HeroViewController",@"ComViewController",@"MoreViewController"];
         
    NSMutableArray *vcArr = [NSMutableArray array];
    for (NSInteger i = 0; i < titles.count; i++) {
        
        Class vcClass = NSClassFromString(classNames[i]);
        BaseViewController *vc = [[vcClass alloc] init];
        vc.title = titles[i];
        
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        
      
        [vcArr addObject:nav];
    }
    self.viewControllers = vcArr;
    
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
