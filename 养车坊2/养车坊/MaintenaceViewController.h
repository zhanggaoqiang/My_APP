//
//  MaintenaceViewController.h
//  养车坊
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"

@interface MaintenaceViewController :BaseViewController
{

AFHTTPRequestOperationManager *_manager;
NSInteger _currentPage;
BOOL _isRefreshing;
BOOL _isLoadMore;
UIRefreshControl *_refreshControl;


}

@property (nonatomic)BOOL isRefreshing;
@property(nonatomic,strong)UIRefreshControl *refreshControl;
@property(nonatomic)NSInteger currentPage;

@property(nonatomic,assign)BOOL isLoadMore;
- (void)creatRefreshView;
//结束刷新
- (void)endRefreshing;

- (void)loadDataPage;


@end
