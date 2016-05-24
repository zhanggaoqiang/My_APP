//
//  LOLViewController.m
//  SeeNews
//
//  Created by qianfeng on 15/8/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LOLViewController.h"
#import "LOLBaseViewController.h"

@interface LOLViewController ()

@end

@implementation LOLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViewControllers];
}
//创建子视图控制器
- (void)creatViewControllers {
    NSArray *vcNames = @[@"ViewController1",@"ViewController2",@"ViewController3",@"ViewController4"];
    NSArray *titles = @[@"最新",@"新闻",@"赛事",@"娱乐"];
    
    NSMutableArray *vcArr = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < vcNames.count; i++) {
        Class vcClass = NSClassFromString(vcNames[i]);
        //vcClass 创建对象
        // vcClass *vc= [[vcClass alloc] init];
       LOLBaseViewController *vc = [[vcClass alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        //导航标题
        vc.navigationItem.title = titles[i];
       
        //标签栏标题
        nav.tabBarItem.title = titles[i];
        NSString *name = [NSString stringWithFormat:@"tab_%ld",i];
        //设置图片
        nav.tabBarItem.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *selectName = [NSString stringWithFormat:@"tab_c%ld",i];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //放入数组
        [vcArr addObject:nav];
     
    }
    //把数组给tabBarController
    self.viewControllers = vcArr;
  
    //设置背景图片
    [self.tabBar setBackgroundImage:[UIImage imageNamed: @"tabbg"]];
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
