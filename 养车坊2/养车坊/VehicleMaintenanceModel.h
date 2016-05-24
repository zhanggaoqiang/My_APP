//
//  VehicleMaintenanceModel.h
//  养车坊
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyModel.h"

@interface VehicleMaintenanceModel : MyModel
@property(nonatomic,strong)NSString *BigTitle;
@property(nonatomic,strong)NSString *ClickCount;
@property(nonatomic,strong)NSString *ContentUrl;
@property(nonatomic,strong)NSString *Image;
@property(nonatomic)NSInteger Vote;
@property(nonatomic,strong)NSString *CategoryName;
@property(nonatomic)NSInteger Heat;
@property(nonatomic,strong)NSString *PublishDateTime;
@end
