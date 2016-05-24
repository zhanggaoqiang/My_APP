//
//  NewsTableViewCell.h
//  SeeNews
//
//  Created by qianfeng on 15/8/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "NewsObject.h"

@interface NewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageviewlabel;

@property (weak, nonatomic) IBOutlet UILabel *labellabel;
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property(nonatomic,strong)NewsObject *model;
-(void)showDataWithModel:(NewsObject*)model;
-(void)showDataWithModel1:(NewsObject*)model;
@end
