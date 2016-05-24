//
//  VehicleMaintenanceTabViewController.m
//  养车坊
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "VehicleMaintenanceTabViewController.h"
#import "BaseViewController.h"
#import "MyControl.h"
#import "DDMenuController.h"
#import "ClassificationViewController.h"
#import "HeadBarViewController.h"

@interface VehicleMaintenanceTabViewController ()


@end

@implementation VehicleMaintenanceTabViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViewControllers];
    // Do any additional setup after loading the view.
}
- (void)creatViewControllers {
    NSArray *titles = @[@"首页",@"汽车新闻",@"服务大全",@"我的"];
    NSArray *classNames=@[@"HeadBarViewController",@"DriveViewController",@"MaintenaceViewController",@"CarViewController"];
    NSArray *arr=@[@"tab_0",@"tab_1",@"tab_2",@"tab_3"];
    NSArray *arr1=@[@"tab_c0",@"tab_c1",@"tab_c2",@"tab_c3"];
    
    
    NSMutableArray *vcArr = [NSMutableArray array];
    for (NSInteger i = 0; i < titles.count; i++) {
    
        Class vcClass = NSClassFromString(classNames[i]);
        BaseViewController *vc = [[vcClass alloc] init];
        vc.title = titles[i];
        
           
           UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        

        nav.tabBarItem.image = [[UIImage imageNamed:arr[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage =[[UIImage imageNamed:arr1[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
           [vcArr addObject:nav];
    }
    self.viewControllers = vcArr;
    
}





@end
