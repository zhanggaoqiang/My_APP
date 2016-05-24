//
//  CircleBottomView.m
//  Travel
//
//  Created by qianfeng on 15/6/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CircleBottomView.h"
#import "UIImageView+WebCache.h"

@implementation CircleBottomView

//@property (weak, nonatomic) IBOutlet UIImageView *bottomImage;
//@property (weak, nonatomic) IBOutlet UILabel *cnLabel;
//@property (weak, nonatomic) IBOutlet UILabel *enLabel;
//@property (weak, nonatomic) IBOutlet UILabel *beentoLabel;
-(void)initUIWithModel:(CityMapModel *)model
{
    self.cnLabel.text=model.cnname;
    self.enLabel.text=model.enname;
    self.beentoLabel.text=model.beenstr;
    [self.bottomImage sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    
}

@end
