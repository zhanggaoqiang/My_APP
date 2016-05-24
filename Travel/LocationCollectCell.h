//
//  LocationCollectCell.h
//  Travel
//
//  Created by qianfeng on 15/6/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationModel.h"

@interface LocationCollectCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel;


-(void)updateCollectionCellWithModel:(LocationModel *)model;

-(CGFloat)getCellHeightWithModel:(LocationModel *)model width:(CGFloat)width;

@end
