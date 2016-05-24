//
//  PriceOffView.h
//  Travel
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceOffModel.h"

@interface PriceOffView : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *priceOffImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceOffLabel;


-(void)updateUIWithModel:(PriceOffModel *)model flag:(int)flag;
//
//-(void)updateUIWithRecommendModel:(RecommendModel *)model;
//
//-(void)updateUIWithDesDiscountModel:(DesDiscountModel *)model;

@end
