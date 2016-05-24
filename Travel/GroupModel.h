//
//  GroupModel.h
//  Travel
//
//  Created by qianfeng on 15/6/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface GroupModel : BaseModel

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * name;
@property(nonatomic)NSArray * group;
@property(nonatomic,copy)NSString * photo;
@property(nonatomic,copy)NSString * total_threads;
@property(nonatomic)NSArray * types;

@end
