//
//  FindScriptCell.m
//  choutixiaoguo
//
//  Created by jxmm on 16/3/3.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "FindScriptCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface FindScriptCell()
    
@property(nonatomic,strong)UIImageView *scriptimage;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *detailDescrption;
@property(nonatomic,strong)UILabel *prize;

@property(nonatomic,strong)UILabel *kindLanel;

@end

@implementation FindScriptCell

- (void)awakeFromNib {

    
    
    
    
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super  initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    [self showUI];
    }
    return self;
}





-(void)showUI {
    self.scriptimage=[[UIImageView alloc] init];
    [self.contentView addSubview:self.scriptimage];
    
    self.nameLabel=[[UILabel alloc] init];
     [self.contentView addSubview:self.nameLabel];
    
    self.detailDescrption=[UILabel new];
    [self addSubview:self.detailDescrption];
    [self.detailDescrption   mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.scriptimage.mas_right).offset(5);
        
        make.width.mas_equalTo(kScreenSize.width-100);
        make.top.equalTo(self.nameLabel.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        

        
        
    }];
    
    
    [self.scriptimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
     
        make.width.mas_equalTo(kScreenSize.width/4);
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        
    }];
    
    
    [self.nameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scriptimage.mas_right).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.equalTo(self.mas_top).offset(5);
        make.height.equalTo(@20);
        
        
    }];
    
 }

-(void)showDataWithModel:(FindScriptModel *)model {
    
    model=model;
    self.detailDescrption.text=model.description1;
    self.prize.text=[model.price   stringValue];
   // self.kindLanel.text=model.type;
    
      self.nameLabel.text=model.title;
    self.nameLabel.text=model.title;
     [self.scriptimage  sd_setImageWithURL:[NSURL  URLWithString:model.img ] placeholderImage:[UIImage   imageNamed:@"380-264"]];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
