//
//  PersonalCenterCollectionViewCell.m
//  choutixiaoguo
//
//  Created by jxmm on 16/3/15.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "PersonalCenterCollectionViewCell.h"
#import "Masonry.h"

@implementation PersonalCenterCollectionViewCell
{
    UIImageView *_imageView;
    UILabel *_label;
    
}


-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self=[super  initWithFrame:frame]) {
        [self  creatViewWithFrame:frame];
    }
    return self;
}



-(void)creatViewWithFrame:(CGRect)frame {
    
    _imageView=[UIImageView new];
    [self.contentView addSubview:_imageView];
    
    
    _label=[UILabel new];
    _label.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_label];
    

    
    [_imageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(self.frame.size.width/3);
        make.right.mas_equalTo(self.mas_right).offset(-self.frame.size.width/3);
        make.top.mas_equalTo(self.mas_top).offset(self.frame.size.width/3-5);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-self.frame.size.width/3+5);
        
    }];
     
       [_label  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.top.mas_equalTo(_imageView.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
        
    }];
    
}



-(void)showDataWithModel:(PersonalCenterModel *)model {
    _label.text=model.contentStr;
    _imageView.image=[UIImage  imageNamed:model.imageName];
    
    
}



@end
