//
//  VideoTableViewCell.m
//  choutixiaoguo
//
//  Created by jxmm on 16/2/26.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"



@interface VideoTableViewCell()
{
    UIImageView *imageView;
}
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *watchTimelabel;
@property(nonatomic,strong)UILabel *commentTimesLabel;
@property(nonatomic,strong)UILabel  *praiseTimesLabel;
@property(nonatomic,strong)UIButton *shareButton;

@end



@implementation VideoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



//-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self=[super  initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self showUI];
//    }
//    return self;
//}
//


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier BlcokBtn:(BlockBtn)sender {
    
    self=[super   initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.shareBtn=sender;
        [self showUI];
    }
    return self;
    
}

-(void)showUI {
    
    
    imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.translatesAutoresizingMaskIntoConstraints=NO;
    [self.contentView addSubview:imageView];
    
    self.titleLabel=[[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints=NO;
    self.titleLabel.font=[UIFont systemFontOfSize:18];
    
    self.watchTimelabel=[UILabel new];
    self.watchTimelabel.font=[UIFont systemFontOfSize:15];
    self.watchTimelabel.text=@"观看:123";
    self.watchTimelabel.translatesAutoresizingMaskIntoConstraints=NO;
    [self.contentView addSubview:self.watchTimelabel];
    
    
  
    
    self.commentTimesLabel=[UILabel new];
  
    
 
    self.commentTimesLabel.font=[UIFont systemFontOfSize:15];
    self.commentTimesLabel.translatesAutoresizingMaskIntoConstraints=NO;
    
    UIImage *image=[UIImage imageNamed:@"评论"];
    
    UIImageView *commentView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    commentView.image=image;
    [self.commentTimesLabel addSubview:commentView];
  
    [self.contentView addSubview:self.commentTimesLabel];
    
    self.praiseTimesLabel=[[UILabel alloc] init];
    self.praiseTimesLabel.text=@"赞:35";
    self.praiseTimesLabel.font=[UIFont systemFontOfSize:15];
    self.praiseTimesLabel.translatesAutoresizingMaskIntoConstraints=NO;
    [self.contentView  addSubview:self.praiseTimesLabel];
    
    self.shareButton=[[UIButton alloc] init];
    [self.shareButton  setImage:[UIImage  imageNamed:@"分享"] forState:UIControlStateNormal];
    [self.shareButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.shareButton.titleLabel.font=[UIFont systemFontOfSize:12];
   // self.shareButton.backgroundColor=[UIColor yellowColor];
    self.shareButton.translatesAutoresizingMaskIntoConstraints=NO;
    self.shareButton.tag=111;
    [self.contentView addSubview:self.shareButton];
    
    [self.shareButton addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [imageView   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(-60);
        make.top.equalTo(self.mas_top).offset(0);
        
}];
    
    [self.titleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(imageView.mas_width);
        make.top.equalTo(imageView.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left).offset(5);
        make.height.equalTo(@20);
        
    }];
    
    [self.watchTimelabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_left).offset(65);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        
    }];
    
    [self.commentTimesLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(70);
        make.right.equalTo(self.mas_right).offset(self.frame.size.width-130);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
    [self.praiseTimesLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_right).offset(-130);
        make.right.equalTo(self.mas_right).offset(self.frame.size.width-130);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    [self.shareButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_right).offset(-60);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
       
    }];
}

-(void)shareBtn:(UIButton *)sender {
           self.shareBtn((int)sender.tag);
 
  
    
}



-(void)showDataWithModel:(AllKindsOfVideoModel *)model {
    
    model=model;
    self.titleLabel.text=model.title;
    [imageView sd_setImageWithURL:[NSURL  URLWithString:model.img]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
