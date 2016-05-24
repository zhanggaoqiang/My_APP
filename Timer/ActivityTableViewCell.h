//
//  ActivityTableViewCell.h
//  Timer
//
//  Created by qianfeng on 15/8/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworking.h"
#import "HomeModel.h"

@interface ActivityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverNamellabel;

@property (weak, nonatomic) IBOutlet UILabel *movienamelabel;

@property (weak, nonatomic) IBOutlet UILabel *summarylabel;

@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property(nonatomic,strong)HomeModel *model;
-(void)showDataWithModel:(HomeModel*)model;



@end
