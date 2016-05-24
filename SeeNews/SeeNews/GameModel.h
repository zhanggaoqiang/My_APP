//
//  GameModel.h
//  SeeNews
//
//  Created by qianfeng on 15/8/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyObject.h"

@interface GameModel : MyObject


@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,strong)NSString *video_url;
@property(nonatomic,strong)NSString *weight_new;
@property(nonatomic,strong)NSString *pic_url;



@end
