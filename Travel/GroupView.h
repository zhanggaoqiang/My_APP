//
//  GroupView.h
//  Travel
//
//  Created by qianfeng on 15/6/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GroupModel;

typedef void (^GroupCellClick)(GroupModel * model);

@interface GroupView : UIView

@property(nonatomic)NSArray * dataArray;

@property(nonatomic,copy)GroupCellClick groupBlock;

@end
