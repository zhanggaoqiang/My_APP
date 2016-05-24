//
//  CollectionViewCell.m
//  养车坊
//
//  Created by qianfeng on 15/8/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CollectionViewCell.h"
#import "ServiceModel.h"
#import "UIImageView+WebCache.h"

@implementation CollectionViewCell
{
    UIImageView *_imageView;
    UILabel *_label;
    
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self creatViewWithFrame:frame];
        
        
    
    }
    return self;
    
    
}


- (void)creatViewWithFrame:(CGRect)frame{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,kScreenSize.width/2-5,100)];
    //粘贴到contentView上
    [self.contentView addSubview:_imageView];
    
    
}
- (void)showDataWithModel:(ServiceModel *)model {
    
  
    
   [_imageView sd_setImageWithURL:[NSURL URLWithString:model.icoimgurl] placeholderImage:[UIImage imageNamed:@"image1.png"]];
    
}




@end
