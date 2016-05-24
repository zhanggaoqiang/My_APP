//
//  DestinationModel.m
//  Travel
//
//  Created by qianfeng on 15/6/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DestinationModel.h"
#import <objc/message.h>

@implementation DestinationModel


// 利用runtime机制进行属性的归档接档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([DestinationModel class], &count);
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([DestinationModel class], &count);
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            // 设置到成员变量身上
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}
//-(void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.id         forKey:@"MyID"];
//    [aCoder encodeObject:self.cnname      forKey:@"MyCnname"];
//    [aCoder encodeObject:self.enname       forKey:@"MyEnname"];
//    [aCoder encodeObject:self.hot_country          forKey:@"MyHotCountry"];
//    [aCoder encodeObject:self.country     forKey:@"MyCountry"];
//    [aCoder encodeObject:self.photo   forKey:@"MyPhoto"];
//    [aCoder encodeObject:self.count      forKey:@"MyCount"];
//    [aCoder encodeObject:self.label forKey:@"MyLabel"];
//}
//
//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self=[super init]) {
//        self.id=[aDecoder decodeObjectForKey:@"MyID"];
//        self.cnname =[aDecoder decodeObjectForKey:@"MyCnname"];
//        self.enname =[aDecoder decodeObjectForKey:@"MyEnname"];
//        self.hot_country    =[aDecoder decodeObjectForKey:@"MyHotCountry"];
//        self.country  =[aDecoder decodeObjectForKey:@"MyCountry"];
//        self.photo =[aDecoder decodeObjectForKey:@"MyPhoto"];
//        self.count   =[aDecoder decodeObjectForKey:@"MyCount"];
//        self.label =[aDecoder decodeObjectForKey:@"MyLabel"];
//    }
//    return self;
//}


@end
