//
//  ActivityTableViewCell.m
//  Timer
//
//  Created by qianfeng on 15/8/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)showDataWithModel:(HomeModel*)model {
    self.model=model;
    
    
    self.movienamelabel.text=model.movieName;
    self.summarylabel.text=model.summary;
    
    
    
    
    [self.coverNamellabel sd_setImageWithURL:[NSURL URLWithString:model.coverImg]];
    
}





@end
