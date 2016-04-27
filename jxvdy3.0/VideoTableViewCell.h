//
//  VideoTableViewCell.h
//  choutixiaoguo
//
//  Created by jxmm on 16/2/26.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllKindsOfVideoModel.h"
typedef void(^BlockBtn)(int);

@interface VideoTableViewCell : UITableViewCell


@property(nonatomic,strong)NSString *movieID;

@property(nonatomic,strong)BlockBtn shareBtn;

-(void)showDataWithModel:(AllKindsOfVideoModel *)model;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  BlcokBtn:(BlockBtn)sender;
@end
