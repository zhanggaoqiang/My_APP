//
//  CarKnologyViewController.h
//  养车坊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface CarKnologyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
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
@end
