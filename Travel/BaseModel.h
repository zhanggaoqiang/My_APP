//
//  BaseModel.h
//  Travel
//
//  Created by qianfeng on 15/6/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

@interface BaseModel :NSObject
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
-(id)valueForUndefinedKey:(NSString *)key;
-(void)setNilValueForKey:(NSString *)key;
@end
