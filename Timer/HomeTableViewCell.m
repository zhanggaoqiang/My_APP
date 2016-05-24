//
//  HomeTableViewCell.m
//  Timer
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)showDataWithModel:(HomeModel*)model {
    self.model=model;
    
    
    self.titlelabel.text=model.title;
    self.publishTimelabel.text=model.publishTime;
    self.commentCountlabel.text= [NSString stringWithFormat:@"%ld",model.commentCount];
    
    
 
    [self.url1label sd_setImageWithURL:[NSURL URLWithString:model.url1 ]];
    [self.url2label sd_setImageWithURL:[NSURL URLWithString:model.url2 ]];
    [self.url3lable sd_setImageWithURL:[NSURL  URLWithString:model.url3]];
    
}




@end
