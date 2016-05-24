//
//  ADView.m
//  Timer
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ADView.h"
#import "MyControl.h"
#import "HomeModel.h"

#import "UIImageView+WebCache.h"
#import "MainlandListViewController.h"
#import "AllNationalViewController.h"

@implementation ADView



{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UILabel *_label;
    NSTimer *_timer;
   
    
    
    
    
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatHttpRequest];
        
        [self loadDataPage];
        
      
        
        
    }
    return self;
}

- (void)creatHttpRequest {
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _dataArr = [[NSMutableArray alloc] init];
}


-(void)loadDataPage{
    
    [_manager GET:HEAD_URL parameters:nil success:^(AFHTTPRequestOperation *operation,
                id responseObject){
        
        
        
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        HomeModel *model=[[HomeModel alloc]init];
        
       
        model.imageUrl = dict[@"news"][@"imageUrl"];
        
        model.titlenews=dict[@"news"][@"title"];
           [_dataArr addObject:model];
        
        [self showUI];
    }
     
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"下载失败");
              
          }];
    
}
- (void)showUI{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 160)];
    
        UIImageView *imageview =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,kScreenSize.width, 160)];
        
        [imageview sd_setImageWithURL:[NSURL URLWithString: [self.dataArr[0] imageUrl]]];
        [_scrollView addSubview:imageview];
   
    _scrollView.contentSize = CGSizeMake(kScreenSize.width, 160);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces=NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 130, kScreenSize.width, 30)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    
    _label = [MyControl creatLabelWithFrame:CGRectMake(10, 0, 300, 30) text:[self.dataArr[0] titlenews]];
    _label.font=[UIFont systemFontOfSize:12];
    
    _label.textColor = [UIColor whiteColor];
    [view addSubview:_label];
    [self addSubview:view];
    NSArray *arr=@[@"内地票房榜",@"全球票房榜"];
    
    
    for (NSInteger i=0; i<2; i++) {
        
        UIButton *button =[[UIButton alloc] initWithFrame:CGRectMake(25+(kScreenSize.width/2-10)*i, 160, kScreenSize.width/2-50, 30)];
        button.backgroundColor=[UIColor lightGrayColor];
        button.tag=101+i;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
}

    
}


-(void)btnClick:(UIButton *)btn {
    
    switch (btn.tag) {
        case 101:{
                     self.adClick();
            
                
            }
     
            
            break;
        case 102:{
            
            self.adClick1();
        }
            break;
            
        default:
            break;
    }
    
    
}


@end
