//
//  CircleBottomView.h
//  Travel
//
//  Created by qianfeng on 15/6/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityMapModel.h"

@interface CircleBottomView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *bottomImage;
@property (weak, nonatomic) IBOutlet UILabel *cnLabel;
@property (weak, nonatomic) IBOutlet UILabel *enLabel;
@property (weak, nonatomic) IBOutlet UILabel *beentoLabel;

-(void)initUIWithModel:(CityMapModel *)model;

@end
