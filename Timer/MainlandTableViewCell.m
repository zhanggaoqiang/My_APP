//
//  MainlandTableViewCell.m
//  Timer
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MainlandTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation MainlandTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showDataWithModel:(HomeModel*)model {
    self.model=model;
    self.namelabel.text=model.name;
    self.nameenlabel.text=model.nameEn;
    self.releaseDatalabel.text=model.releaseData;
    self.weekboxoffice.text =model.weekBoxOffice;
    self.totalBoxoffice.text=model.totalBoxOffice;
    self.dictorlabel.text=model.dictor;
    self.actorlabel.text=model.actor;
    
    
    
    
    

    [self.posterUrllabel sd_setImageWithURL:[NSURL URLWithString:model.posterUrl]];
    
}





@end
