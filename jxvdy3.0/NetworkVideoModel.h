//
//  NetworkVideoModel.h
//  choutixiaoguo
//
//  Created by jxmm on 16/3/3.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkVideoModel : NSObject
@property(nonatomic,strong)NSNumber* id;
@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSString*img;
@property(nonatomic,strong)NSString*score;
@property(nonatomic,strong)NSString*description;
@property(nonatomic,strong)NSNumber*maxepisode;
@property(nonatomic,strong)NSNumber*maxid;

@end
