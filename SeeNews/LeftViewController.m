//
//  LeftViewController.m
//  SeeNews
//
//  Created by qianfeng on 15/8/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LeftViewController.h"
#import "HomeViewController.h"
#import "DDMenuController.h"
#import "NewsTableViewCell.h"
#import "BaseViewController.h"


@interface LeftViewController ()
{
    
    NSArray *_arr;
}

@end

@implementation LeftViewController

@synthesize tableView=_tableView;

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

-(void)dataInit {
    
    _arr=@[@"新闻",@"游戏",@"图片",@"视频"];
    
    
    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInit];
    if (!_tableView) {
        
        
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-64-49) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.delegate = (id<UITableViewDelegate>)self;
        tableView.dataSource = (id<UITableViewDataSource>)self;
       
        [self.view addSubview:tableView];
        self.tableView = tableView;
    }
    
}
    - (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
        return 4;
    }
    
    - (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
        static NSString *CellIdentifier = @"CellIdentifier";
      NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil) {
            cell = [[NewsTableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        /*
         * Content in this cell should be inset the size of kMenuOverlayWidth
         */
        
        cell.textLabel.text = _arr[indexPath.row];
        return cell;
        
    }
    
    - (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
        return @"分类选择";
    }
    
    
#pragma mark - UITableViewDelegate
    
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSArray *titles =@[@"HomeViewController",@"LOLViewController",@"PictureViewController",@"VideoViewController"];
    
    
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    

        
        Class vcClass = NSClassFromString(titles[indexPath.row]);
        BaseViewController *vc = [[vcClass alloc] init];
   
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [menuController setRootController:navController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
