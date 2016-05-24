//
//  NewsInfroTableViewCell.m
//  LOL盒子
//
//  Created by qianfeng on 15/8/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewsInfroTableViewCell.h"
#import "UIImageView+WebCache.h"


@implementation NewsInfroTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showDataWithModel:(NewsInforModel *)model {
    self.model=model;
    self.titlelabel.text=model.title;
    self.desclabel.text=model.desc;
  // [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    
}





@end
