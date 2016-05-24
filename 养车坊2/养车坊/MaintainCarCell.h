//
//  MaintainCarCell.h
//  养车坊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "MainCarModel.h"


@interface MaintainCarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property(nonatomic,strong)MainCarModel *model;
-(void)showDataWithModel1:(MainCarModel*)model;



@end
