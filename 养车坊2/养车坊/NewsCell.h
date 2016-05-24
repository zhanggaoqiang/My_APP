//
//  NewsCell.h
//  养车坊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "TopicModel.h"

@interface NewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UILabel *newslinelabel;

@property (weak, nonatomic) IBOutlet UILabel *comentlabel;
@property (weak, nonatomic) IBOutlet UILabel *categorylabel;





@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)TopicModel *model;

-(void)showDataWithModel:(TopicModel*)model;


@end
