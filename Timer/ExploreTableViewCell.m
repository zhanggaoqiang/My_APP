//
//  ExploreTableViewCell.m
//  Timer
//
//  Created by qianfeng on 15/8/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ExploreTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ExploreTableViewCell

- (void)awakeFromNib {
    
    self.usernamelabel.layer.masksToBounds=YES;
    self.usernamelabel.layer.cornerRadius=17.5;
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showDataWithModel:(HomeModel*)model {
    self.model=model;
    
    
   
    self.summarylabel.text=model.summary;
    self.nicknamelabel.text=model.nickname;
    self.titlelabel.text=model.title;
    
    
    
    
    
    [self.usernamelabel sd_setImageWithURL:[NSURL URLWithString:model.username]];
    [self.imagelabel  sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
    
}




@end
