//
//  MyObject.h
//  SeeNews
//
//  Created by qianfeng on 15/8/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyObject : NSObject

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
-(id)valueForUndefinedKey:(NSString *)key;

@end
