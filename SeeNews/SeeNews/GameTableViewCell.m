//
//  GameTableViewCell.m
//  SeeNews
//
//  Created by qianfeng on 15/8/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GameTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation GameTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self showUI];
    }
    return self;
}
//创建控件 没有数据
- (void)showUI{
    
    self.titlelabel.frame =CGRectMake(300, 0, kScreenSize.width-100, 100);
    self.picurllabel.frame=CGRectMake(0, 0, kScreenSize.width/3, 10);
    [self.contentView  addSubview:self.titlelabel];
    //全部贴在 contontView上
    //contontView上粘贴控件是为了 不修改系统自带 结构
    [self.contentView addSubview:self.picurllabel];
    
    
    
    
    
}











-(void)showDataWithModel:(GameModel *)model {
    self.model=model;
    self.titlelabel.frame =CGRectMake(300, 0, kScreenSize.width-100, 100);
    self.picurllabel.frame=CGRectMake(0, 0, kScreenSize.width/3, 10);
    [self.contentView  addSubview:self.titlelabel];
    //全部贴在 contontView上
    //contontView上粘贴控件是为了 不修改系统自带 结构
    [self.contentView addSubview:self.picurllabel];
    
    
    
    self.titlelabel.text=model.title;
    self.desclabel.text=model.desc;
    
    [self.picurllabel sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    
    
    // [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    
}



@end
