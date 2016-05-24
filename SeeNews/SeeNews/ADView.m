//
//  ADView.m
//  SeeNews
//
//  Created by qianfeng on 15/8/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ADView.h"
#import "MyControl.h"
#import "NewsObject.h"
#import "UIImageView+WebCache.h"






@implementation ADView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UILabel *_label;
    NSTimer *_timer;
    NSInteger _s;
    
    
 
    
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatHttpRequest];
        
        [self loadDataPage];
    
        _timer =[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timer) userInfo:nil  repeats:1];
        
        
    }
    return self;
}

-(void)timer {
   // static BOOL flag;
  
        _s+=kScreenSize.width;
    
    if(_s==3*kScreenSize.width)
    {
        _s=0;
        
    }
    
  
    
     _pageControl.currentPage = _s/kScreenSize.width;
    [_scrollView setContentOffset:CGPointMake(_s, 0) animated:YES];
    
    
  }



- (void)creatHttpRequest {
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _dataArr = [[NSMutableArray alloc] init];
}


-(void)loadDataPage{
    

    __weak typeof(self) mySelf =self;
    
  // ://hot.news.cntv.cn/index.php?controller=list&action=getHandDataInfoNew&handdata_id=TDAT1372928688333145&n1=3&n2=20&toutuNum=3
   
    
    
    
    [_manager GET:HeadNews parameters:nil success:^(AFHTTPRequestOperation *operation,
                                                id responseObject){
        
       
            
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
            NSArray *itemArr=dict[@"data"][@"bigImg"];
            
            for (NSDictionary*itemDict in itemArr) {
                
                NewsObject *model=[[NewsObject alloc] init];
                
            
                   model.itemImage=itemDict[@"itemImage"];
                model.itemTitle=itemDict[@"itemTitle"];
                
                                         
                [mySelf.dataArr addObject:model];
                
            }
        [self showUI];
        }
     
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"下载失败");
              
          }];

}
- (void)showUI{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 160)];
    for (int i = 0; i < self.dataArr.count; i++) {

    UIImageView *imageview =[[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width*i , 0, kScreenSize.width, 160)];
        
    [imageview sd_setImageWithURL:[NSURL URLWithString: [self.dataArr[i] itemImage]]];
        [_scrollView addSubview:imageview];
    }
    _scrollView.contentSize = CGSizeMake(kScreenSize.width*3, 160);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces=NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 130, kScreenSize.width, 30)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    
    _label = [MyControl creatLabelWithFrame:CGRectMake(10, 0, 300, 30) text:[self.dataArr[0] itemTitle] ];
    _label.font=[UIFont systemFontOfSize:12];
    
    _label.textColor = [UIColor whiteColor];
    [view addSubview:_label];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(300, 0, 100, 30)];
    _pageControl.numberOfPages = 3;
    //添加翻页触发事件
    [_pageControl addTarget:self action:@selector(pageControl:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:_pageControl];
    [self addSubview:view];
    
}
//控制滚动
- (void)pageControl:(UIPageControl *)page{
    
    
    
    [_scrollView setContentOffset:CGPointMake(_pageControl.currentPage*kScreenSize.width, 0) animated:YES];
    _label.text = [self.dataArr[page.currentPage] itemTitle];  ;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    _pageControl.currentPage = point.x/kScreenSize.width;
    _label.text = [self.dataArr[_pageControl.currentPage]itemTitle]   ;
}




@end
