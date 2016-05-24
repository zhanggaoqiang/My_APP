//
//  ActivityViewController.h
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"

#import "AFNetworking.h"



@interface ActivityViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    AFHTTPRequestOperationManager *_manager;
    NSInteger _currentPage;
    BOOL _isRefreshing;
    BOOL _isLoadMore;
    UIRefreshControl *_refreshControl;
    
    
}



@property(nonatomic,strong)UIRefreshControl *refreshControl;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic)NSInteger currentPage;
@property(nonatomic,assign)BOOL isRefreshing;
@property(nonatomic,assign)BOOL isLoadMore;
//@property(nonatomic,copy)NSString *max_timestamp;


- (void)loadDataPage:(NSInteger)page;
-(void)endRefreshing ;




@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
