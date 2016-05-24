//
//  NewsCell.m
//  养车坊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"

@implementation NewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

-(void)showDataWithModel:(TopicModel *)model {
    self.model=model;
 
    
    
    self.newslinelabel.text=model.newsTitle;
      self.comentlabel.text=[NSString stringWithFormat:@"赞:%ld",model.commentCount ] ;
    self.categorylabel.text=model.newsCategory;
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.newsImage]placeholderImage:[UIImage imageNamed:@"2_3.jpg"]];
    
    
    
}



@end
