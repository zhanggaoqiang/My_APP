//
//  ADView.h
//  Timer
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "HomeModel.h"
typedef void (^ADClick)(void);



@interface ADView : UIView<UIScrollViewDelegate>

{
    
    
    AFHTTPRequestOperationManager *_manager;
    NSMutableArray *_dataArr;
    
}


@property(nonatomic,strong)ADClick adClick;
@property(nonatomic,strong)ADClick adClick1;

;
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)NSMutableArray *dataArr;
- (void)loadDataPage;





@end
