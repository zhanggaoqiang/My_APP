//
//  HeadViewForSection.h
//  Travel
//
//  Created by qianfeng on 15/6/6.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadViewForSection : UICollectionReusableView

@property(nonatomic)UILabel * headLabel;

-(void)updateHeadLabelWithString:(NSString *)string;

@end
