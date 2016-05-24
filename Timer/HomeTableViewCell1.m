//
//  HomeTableViewCell1.m
//  Timer
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HomeTableViewCell1.h"
#import "UIImageView+WebCache.h"

@implementation HomeTableViewCell1

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showDataWithModel:(HomeModel*)model {
    self.model=model;
    
    
    self.labellabel.text=model.title;
    self.title2label.text=model.title2;
    self.commentlabel.text=[NSString stringWithFormat:@"%ld",model.commentCount];
    
    
    [self.imagelabel sd_setImageWithURL:[NSURL URLWithString:model.image]];
     
}



@end
