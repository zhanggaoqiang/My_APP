//
//  CommentCell.m
//  choutixiaoguo
//
//  Created by jxmm on 16/3/18.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell()

@property(nonatomic,strong)UILabel *memberNameLabel;
@property(nonatomic,strong)UILabel  *dataLabel;
@property(nonatomic,strong)UILabel *remarkLabel;
@property(nonatomic,strong)UILabel *praiseTimesLabel;
@property(nonatomic,strong)UIImageView *cellImage;

@end

@implementation CommentCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super  initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self showUI];
    }
    return self;
 }

-(void)showUI {
    

    
    self.cellImage=[UIImageView new];
    self.cellImage.layer.masksToBounds=YES;
    self.cellImage.layer.cornerRadius=25;
    self.cellImage.backgroundColor=[UIColor redColor];
    [self addSubview:self.cellImage];
    
    self.memberNameLabel=[UILabel new];
    [self  addSubview:self.memberNameLabel];
    
    self.dataLabel=[UILabel new];
    self.dataLabel.font=[UIFont  systemFontOfSize:12];
    [self  addSubview:self.dataLabel];
    
    
    self.remarkLabel=[UILabel new];
    self.remarkLabel.font=[UIFont systemFontOfSize:14];
    self.remarkLabel.numberOfLines=0;
    [self addSubview:self.remarkLabel];
    
    [self.remarkLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.width.mas_equalTo(kScreenSize.width-10);
        make.top.mas_equalTo(self.mas_top).offset(60);
       // make.height.mas_equalTo(50);
        
        
    }];
    
    
    
    [self.dataLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self .cellImage.mas_right).offset(5);

        make.width.mas_equalTo(150);
        make.top.mas_equalTo(self.mas_top).offset(30);
        make.height.mas_equalTo(15);

        
        
    }];
    
    [self.memberNameLabel   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self .cellImage.mas_right).offset(5);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.height.mas_equalTo(20);
        
    }];
    
    
    [self.cellImage   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.width.mas_equalTo(50);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.height.mas_equalTo(50);
        
        
    }];
}

     
-(void)showData:(CommentModel *)model {
    self.remarkLabel.text=model.content;
    self.dataLabel.text=model.time;
    self.memberNameLabel.text=model.nick;
    [self.cellImage sd_setImageWithURL:[NSURL   URLWithString:model.face] placeholderImage:[UIImage  imageNamed:@"用户名.png"]];
    
         
}




@end
