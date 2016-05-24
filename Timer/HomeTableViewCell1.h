//
//  HomeTableViewCell1.h
//  Timer
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "HomeModel.h"
@interface HomeTableViewCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imagelabel;


@property (weak, nonatomic) IBOutlet UILabel *labellabel;

@property (weak, nonatomic) IBOutlet UILabel *title2label;


@property (weak, nonatomic) IBOutlet UILabel *commentlabel;


@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property(nonatomic,strong)HomeModel *model;
-(void)showDataWithModel:(HomeModel*)model;



@end
