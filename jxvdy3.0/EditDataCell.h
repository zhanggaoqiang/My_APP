//
//  EditDataCell.h
//  JXiPhoneApp
//
//  Created by jxmm on 14-8-27.
//  Copyright (c) 2014年 Jinxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface EditDataCell : UITableViewCell

@property (nonatomic,retain) UIImageView* headImage;
@property (nonatomic,strong) UILabel* info;
@property (nonatomic,strong)UIButton* button;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier flag:(BOOL)flag;
@end
