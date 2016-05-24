//
//  ADView.h
//  SeeNews
//
//  Created by qianfeng on 15/8/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface ADView : UIView<UIScrollViewDelegate>
{
   
   
    AFHTTPRequestOperationManager *_manager;
     NSMutableArray *_dataArr;
 
}

@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)NSMutableArray *dataArr;
- (void)loadDataPage;



@end
