//
//  ZGQHelp.m
//  choutixiaoguo
//
//  Created by jxmm on 16/3/21.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "ZGQHelp.h"

@implementation ZGQHelp

+ (NSString *)dateStringFromNumberTimer:(NSString *)timerStr {
    //转化为Double
    double t = [timerStr doubleValue];
    //计算出距离1970的NSDate
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:t];
    //转化为 时间格式化字符串
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //转化为 时间字符串
    return [df stringFromDate:date];
}
//动态 计算行高
//根据字符串的实际内容的多少 在固定的宽度和字体的大小，动态的计算出实际的高度
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
    if ([ZGQHelp getCurrentIOS] >= 7.0) {
        //iOS7之后
        /*
         第一个参数: 预设空间 宽度固定  高度预设 一个最大值
         第二个参数: 行间距
         第三个参数: 属性字典 可以设置字体大小
         */
        //xxxxxxxxxxxxxxxxxx
        //ghjdgkfgsfgskdgfjk
        //sdhgfsdjkhgfjd
        
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
        CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil];
        //返回计算出的行高
        return rect.size.height;
        
    }else {
        //iOS7之前
        /*
         1.第一个参数  设置的字体固定大小
         2.预设 宽度和高度 宽度是固定的 高度一般写成最大值
         3.换行模式 字符换行
         */
        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:CGSizeMake(textWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        return textSize.height;//返回 计算出得行高
    }
}

//获取iOS版本号
+ (double)getCurrentIOS {
    
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}
//获取当前app版本号
+(NSString *)getAppVersion {
    NSDictionary *infoDictionary=[[NSBundle mainBundle] infoDictionary];
    NSString *appCurrentVersion=[infoDictionary  objectForKey:@"CFBundleShortVersionString"];
    return appCurrentVersion;

}


//计算一个文件夹大小
+(float)fileSizeForDir:(NSString*)path//计算文件夹下文件的总大小
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float size =0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
        for(int i = 0; i<[array count]; i++)
        {
            NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
            BOOL isDir;
            if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
            {
                NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
                size+= fileAttributeDic.fileSize/ 1024.0/1024.0;
            }
            else
            {
                [self fileSizeForDir:fullPath];
            }
        }
    }
    
    return size;
}











@end
