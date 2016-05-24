//
//  BaseViewCell.h
//  养车坊
//
//  Created by qianfeng on 15/8/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface BaseViewCell : UICollectionViewCell

- (void)showDataWithModel:(BaseModel *)model;


@end
