//
//  CoreDataManager.h
//  Travel
//
//  Created by qianfeng on 15/6/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CoreDataManager : NSObject

+(instancetype)defaultCoreManager;

-(void)addModelFromNetWork:(NSArray *)array entityName:(NSString *)name;

-(NSMutableArray *)fetchModelFromCoreDataWithEntityName:(NSString *)name;

-(void)removeAllModelFromCoreDataWithEntityName:(NSString *)name;

@end
