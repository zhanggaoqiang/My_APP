//
//  ZGQHelp.h
//  choutixiaoguo
//
//  Created by jxmm on 16/3/21.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGQHelp : NSObject
//把一个秒字符串 转化为真正的本地时间
//@"1419055200" -> 转化 日期字符串
+ (NSString *)dateStringFromNumberTimer:(NSString *)timerStr;
//根据字符串内容的多少  在固定宽度 下计算出实际的行高
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size;
//获取 当前设备版本
+ (double)getCurrentIOS;
//获取当前app版本号
+ (NSString *) getAppVersion;
+(float)fileSizeForDir:(NSString*)path;//计算文件夹下文件的总大小

@end
