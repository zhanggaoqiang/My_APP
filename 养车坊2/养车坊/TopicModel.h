//
//  TopicModel.h
//  养车坊
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyModel.h"

@interface TopicModel : MyModel

@property(nonatomic,strong)NSString *newsTitle;
@property(nonatomic,strong)NSString *newsLink;
@property(nonatomic,strong)NSString *newsCategory;
@property(nonatomic,strong)NSString *newsImage;
@property(nonatomic,assign)NSInteger commentCount;
@property(nonatomic,strong)NSString * newsCreatTime;





@end
