//
//  ExploreTableViewCell.h
//  Timer
//
//  Created by qianfeng on 15/8/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "HomeModel.h"

@interface ExploreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titlelabel;


@property (weak, nonatomic) IBOutlet UIImageView *imagelabel;

@property (weak, nonatomic) IBOutlet UILabel *nicknamelabel;

@property (weak, nonatomic) IBOutlet UIImageView *usernamelabel;

@property (weak, nonatomic) IBOutlet UILabel *summarylabel;

@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property(nonatomic,strong)HomeModel *model;
-(void)showDataWithModel:(HomeModel*)model;




@end
