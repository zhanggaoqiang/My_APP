//
//  PicCell.m
//  养车坊
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//



#import "PicCell.h"
#import "UIImageView+WebCache.h"
#define kScreenSize [UIScreen mainScreen].bounds.size

@implementation PicCell

- (void)awakeFromNib {
    // Initialization code
}







-(void)showDataWithModel:(VehicleMaintenanceModel *)model {
    self.model=model;
    self.datelabel.text =  model.PublishDateTime;
    self.votelabel.text=[NSString stringWithFormat:@"赞:%ld",(long)model.Vote ];
    self.bigtitlelabel.text=model.BigTitle;
    self.categorynamelabel.text=model.CategoryName;
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.Image]];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
