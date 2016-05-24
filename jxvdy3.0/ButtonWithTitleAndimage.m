//
//  ButtonWithTitleAndimage.m
//  choutixiaoguo
//
//  Created by jxmm on 16/3/15.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "ButtonWithTitleAndimage.h"
#import "Masonry.h"

@implementation ButtonWithTitleAndimage

-(id)initWithFrame:(CGRect)frame {
    
    if(self =[super init]){
        UILabel *label=[UILabel new];
        label.text=@"ahsjdfh";
        label.backgroundColor=[UIColor redColor];
        
        [self addSubview:label];
        
        
        
        UIImageView *imageView=[UIImageView  new];
        imageView.image=[UIImage   imageNamed:@"150-210"];
        [self addSubview:imageView];
        
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.mas_equalTo(self.mas_left).offset(5);
            make.right.mas_equalTo(self.mas_right).offset(-5);
    
            
            
        }];
        
    }
     return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
