//
//  LeftVC2.h
//  choutixiaoguo
//
//  Created by jxmm on 16/1/13.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "LeftBaseViewController.h"

#import "AFNetworking.h"

@interface MicroVideoController : LeftBaseViewController


{
    AFHTTPRequestOperationManager *_manager;
    NSMutableArray *_dataArr;
}
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic)BOOL isRefreshing;
@property (nonatomic,copy) NSString *requestUrl;
@property(nonatomic,strong)UITableView *videoTableView;


@property (nonatomic)BOOL isLoadMoring;

-(void)loadDataPage;


@end
