//
//  NewsTableViewCell.m
//  SeeNews
//
//  Created by qianfeng on 15/8/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsObject.h"

#import "UIImageView+WebCache.h"
@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showDataWithModel:(NewsObject *)model {
    self.model=model;
    
    
    self.labellabel.text=model.itemTitle;
    
    
    
    
    
    // [self.imageviewlabel sd_setImageWithURL:[NSURL URLWithString:model.imgUrl1]];
    [self.imageviewlabel sd_setImageWithURL:[NSURL URLWithString:model.imgUrl1   ]placeholderImage:[UIImage imageNamed:@"0.png"]];
    
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
    
    self.labellabel.frame =CGRectMake(300, 0, kScreenSize.width-100, 100);
    self.imageviewlabel.frame=CGRectMake(0, 0, kScreenSize.width/3, 10);
    [self.contentView  addSubview:self.imageviewlabel];
    //全部贴在 contontView上
    //contontView上粘贴控件是为了 不修改系统自带 结构
    [self.contentView addSubview:self.labellabel];

    
    
    

   }



-(void)showDataWithModel1:(NewsObject *)model {
//    self.model=model;
//    
//    self.labellabel.frame =CGRectMake(100, 0, kScreenSize.width-100, 100);
//    self.imageviewlabel.frame=CGRectMake(0, 0, kScreenSize.width/3, 10);
//    [self.contentView  addSubview:self.imageviewlabel];
//    
//    
//    
//    //全部贴在 contontView上
//    //contontView上粘贴控件是为了 不修改系统自带 结构
//    [self.contentView addSubview:self.labellabel];
//    
//    
//    self.labellabel.text=model.itemTitle;
//    
// 
//    
//    
//    
//    // [self.imageviewlabel sd_setImageWithURL:[NSURL URLWithString:model.imgUrl1]];
//    [self.imageviewlabel sd_setImageWithURL:[NSURL URLWithString:model.imgUrl1   ]placeholderImage:[UIImage imageNamed:@"0.png"]];
//    
}








@end
