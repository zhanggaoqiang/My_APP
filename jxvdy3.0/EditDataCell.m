//
//  EditDataCell.m
//  JXiPhoneApp
//
//  Created by jxmm on 14-8-27.
//  Copyright (c) 2014年 Jinxiang. All rights reserved.
//

#import "EditDataCell.h"

@implementation EditDataCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier flag:(BOOL)flag
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _info = [[UILabel alloc] initWithFrame:CGRectMake(70+29+15, 13.5, 290-99-20-8.5, 17)];
        _info.textColor = GRAY_DETAIL;
        _info.textAlignment = NSTextAlignmentRight;
        _info.font=[UIFont systemFontOfSize:16];
        _info.backgroundColor = [UIColor clearColor];
        [self addSubview:_info];
        
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame=CGRectMake(305-8.5, 15, 8.5, 15);
        _button.tag=3;
        [_button setImage:[UIImage imageNamed:@"跳转"] forState:UIControlStateNormal];
        [self addSubview:_button];
        
        if (flag) {
            _button.frame=CGRectMake(305-8.5, 30, 8.5, 15);
            _info.hidden=YES;
            
            _headImage=[[UIImageView alloc] init];
            _headImage.frame=CGRectMake(213, 5, 64, 64);
            _headImage.layer.cornerRadius=32;
            _headImage.clipsToBounds=YES;
            [self addSubview:_headImage];
        }
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
