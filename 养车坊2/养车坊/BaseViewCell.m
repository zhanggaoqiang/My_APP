//
//  BaseViewCell.m
//  养车坊
//
//  Created by qianfeng on 15/8/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewCell.h"
#import "UIImageView+WebCache.h"

#import "BaseModel.h"

#define kScreenSize [UIScreen mainScreen].bounds.size


@implementation BaseViewCell

{
    UIImageView *_imageView;
    UILabel *_label1;
    UILabel *_label2;
    UILabel *_label3;
   
    
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self creatViewWithFrame:frame];
        
        
        
    }
    return self;
    
    
}


- (void)creatViewWithFrame:(CGRect)frame{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,kScreenSize.width/2-5,150)];
    //粘贴到contentView上
    [self.contentView addSubview:_imageView];
    
    _label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 150, kScreenSize.width/2-5, 50)];
    _label1.numberOfLines=0;
    [self.contentView addSubview:_label1];
    
     _label2=[[UILabel alloc] initWithFrame:CGRectMake(0, 200, kScreenSize.width/2,20 )];
    [self.contentView addSubview:_label2];
    
}
- (void)showDataWithModel:(BaseModel *)model {
 
    _label1.text=model.DisplayName;
    _label2.text=model.Price;
    
    
    _label1.font=[UIFont systemFontOfSize:12];
    _label2.font=[UIFont systemFontOfSize:12];

    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.Image] placeholderImage:[UIImage imageNamed:@"image1.png"]];
    
}


@end
