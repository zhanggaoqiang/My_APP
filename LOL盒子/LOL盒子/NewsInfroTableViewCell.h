//
//  NewsInfroTableViewCell.h
//  LOL盒子
//
//  Created by qianfeng on 15/8/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsInforModel.h"
#import "AFNetworking.h"



@interface NewsInfroTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageviewlabel;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *desclabel;
@property(nonatomic,strong)NewsInforModel *model;
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
-(void)showDataWithModel:(NewsInforModel*)model;
@end
