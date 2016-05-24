//
//  MainlandTableViewCell.h
//  Timer
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "HomeModel.h"

@interface MainlandTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *posterUrllabel;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;


@property (weak, nonatomic) IBOutlet UILabel *nameenlabel;

@property (weak, nonatomic) IBOutlet UILabel *releaseDatalabel;

@property (weak, nonatomic) IBOutlet UILabel *weekboxoffice;
@property (weak, nonatomic) IBOutlet UILabel *totalBoxoffice;

@property (weak, nonatomic) IBOutlet UILabel *dictorlabel;

@property (weak, nonatomic) IBOutlet UILabel *actorlabel;



@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property(nonatomic,strong)HomeModel *model;
-(void)showDataWithModel:(HomeModel*)model;




@end
