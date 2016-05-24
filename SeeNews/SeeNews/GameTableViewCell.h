//
//  GameTableViewCell.h
//  SeeNews
//
//  Created by qianfeng on 15/8/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GameModel.h"
#import "AFNetworking.h"


@interface GameTableViewCell : UITableViewCell


@property(strong ,nonatomic)UILabel *titlelabel;
@property(strong,nonatomic)UILabel *desclabel;
@property(nonatomic,strong)UIImageView *picurllabel;;

@property(nonatomic,strong)GameModel *model;
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
-(void)showDataWithModel:(GameModel*)model;



@end
