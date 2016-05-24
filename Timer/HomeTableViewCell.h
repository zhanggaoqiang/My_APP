//
//  HomeTableViewCell.h
//  Timer
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "HomeModel.h"


@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titlelabel;

@property (weak, nonatomic) IBOutlet UIImageView *url1label;


@property (weak, nonatomic) IBOutlet UIImageView *url2label;

@property (weak, nonatomic) IBOutlet UIImageView *url3lable;

@property (weak, nonatomic) IBOutlet UILabel *publishTimelabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountlabel;


@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property(nonatomic,strong)HomeModel *model;
-(void)showDataWithModel:(HomeModel*)model;



@end
