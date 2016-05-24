//
//  HotCityCell.h
//  Travel
//
//  Created by qianfeng on 15/6/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesHotCityModel.h"

@interface HotCityCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *cnnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ennameLabel;

-(void)updateCellUIWithModel:(DesHotCityModel *)model;

@end
