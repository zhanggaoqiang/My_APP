//
//  GroupDetailCell.h
//  Travel
//
//  Created by qianfeng on 15/6/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupDetailModel.h"

@interface GroupDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

-(void)updateCellWithModel:(GroupDetailModel *)model;

@end
