//
//  FindScriptModel.h
//  choutixiaoguo
//
//  Created by jxmm on 16/3/3.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindScriptModel : NSObject

@property(nonatomic,strong)NSNumber *idScript;
@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSString*img;
@property(nonatomic,strong)NSString*description1;
@property(nonatomic,strong)NSNumber*time;
@property(nonatomic,strong)NSArray *type;
@property(nonatomic,strong)NSNumber*price;
@property(nonatomic,strong)NSNumber*mycollect;


@end
