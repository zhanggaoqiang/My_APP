//
//  GroupDetailCell.m
//  Travel
//
//  Created by qianfeng on 15/6/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GroupDetailCell.h"

@implementation GroupDetailCell

//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;
//
//@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

- (void)awakeFromNib {
    // Initialization code
}

-(void)updateCellWithModel:(GroupDetailModel *)model
{
    self.titleLabel.text=model.title;
    self.viewsLabel.text=model.views;
    self.commentLabel.text=model.replys;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
