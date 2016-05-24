//
//  DesCountryModel.h
//  Travel
//
//  Created by qianfeng on 15/6/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseModel.h"

@interface DesCountryModel : BaseModel

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * cnname;
@property(nonatomic,copy)NSString * enname;
//@property(nonatomic,copy)NSString * planto;
//@property(nonatomic,copy)NSString * beento;
@property(nonatomic)NSArray *  photos;
//@property(nonatomic,copy)NSString * overview_url;
//@property(nonatomic)BOOL has_guide;
//@property(nonatomic)BOOL has_trip_list;
//@property(nonatomic)BOOL has_plan;
@property(nonatomic)NSArray * hot_city;
@property(nonatomic)NSArray * n_discount;
@property(nonatomic)NSArray * n_trip;

@end
