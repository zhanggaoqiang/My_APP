//
//  MyCollectionViewCell.h
//  Travel
//
//  Created by qianfeng on 15/6/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"

@interface MyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totleThreadLabel;

-(void)updateCellViewWithModel:(GroupModel *)model;

@end
