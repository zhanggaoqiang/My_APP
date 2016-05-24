//
//  HeadViewForDestinationView.h
//  Travel
//
//  Created by qianfeng on 15/6/6.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AreaChooseBlockHandler)(NSInteger tag);
@interface HeadViewForDestinationView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *headLabel;

@property(nonatomic)UIButton * currentButton;
@property(nonatomic,copy)AreaChooseBlockHandler areaBlock;


-(void)updateHeadLabelWithString:(NSString *)string;

@end
