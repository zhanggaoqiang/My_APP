//
//  MaintainCarCell.m
//  养车坊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MaintainCarCell.h"
#import "UIImageView+WebCache.h"


@implementation MaintainCarCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}


-(void)showDataWithModel1:(MainCarModel *)model {
    self.model=model;
    self.namelabel.text=model.modelname;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.icoimgurl]placeholderImage:[UIImage imageNamed:@"0.png"]];
    
}




@end
