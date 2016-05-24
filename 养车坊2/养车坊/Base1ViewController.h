//
//  Base1ViewController.h
//  养车坊
//
//  Created by qianfeng on 15/8/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface Base1ViewController : UIViewController

{
    AFHTTPRequestOperationManager *_manager;
    NSInteger _currentPage;
    BOOL _isRefreshing;
    BOOL _isLoadMore;
    UIRefreshControl *_refreshControl;
    NSInteger _index;
    
    
}

@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)UIRefreshControl *refreshControl;
@property(nonatomic)NSInteger currentPage;
@property(nonatomic,assign)BOOL isRefreshing;
@property(nonatomic,assign)BOOL isLoadMore;


- (void)loadDataPage;





@end
