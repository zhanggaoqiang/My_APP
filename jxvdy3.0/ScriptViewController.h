//
//  ScriptViewController.h
//  choutixiaoguo
//
//  Created by jxmm on 16/3/4.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "LeftBaseViewController.h"
#import "AFNetworking.h"

@interface ScriptViewController : LeftBaseViewController

{
    AFHTTPRequestOperationManager *_manager;
    NSMutableArray *_dataArr;
}
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic)BOOL isRefreshing;
@property (nonatomic,copy) NSString *requestUrl;

-(void)loadDataPage;



@end
