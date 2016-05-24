//
//  BaseView.m
//  SeeNews
//
//  Created by qianfeng on 15/8/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseView.h"

#import "NewsObject.h"
#import "NewsTableViewCell.h"
#import "JHRefresh.h"
#import "ADView.h"

@interface BaseView ()


@end


@implementation BaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isLoadMore = NO;
        self.isRefreshing = NO;
        self.currentPage = 1;
        [self creatTableView];
        [self creatHttpRequest];
        [self loadDataPage:self.currentPage];
        [self creatRefreshView];
        
        
        
        
        
    }
    return self;
}

- (void)creatTableView {

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-94) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
 
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    [self addSubview:self.tableView];

 
    self.tableView.tableHeaderView=[[ADView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 160)];
    
    
    
}
- (void)creatHttpRequest {
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _dataArr = [[NSMutableArray alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    NewsObject*model = _dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(void)loadDataPage:(NSInteger)page {
    
    NSString *newUrl =[NSString stringWithFormat:HeadNews3,self.currentPage];
    
    
    __weak typeof(self) mySelf =self;
    [_manager GET:newUrl parameters:nil success:^(AFHTTPRequestOperation *operation,
                                                  id responseObject){
        
        if (self.currentPage==1) {
            [self.dataArr removeAllObjects];
            
        }
        
        
        if (responseObject) {
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray *itemArr=dict[@"data"][@"itemList"];
            
            for (NSDictionary*itemDict in itemArr) {
                
                
                
                NewsObject *model =[[NewsObject alloc] init];
                
                model.itemTitle=itemDict[@"itemTitle"];
                
                
                model.imgUrl1=itemDict[@"itemImage"][@"imgUrl1"];
                
                
                [mySelf.dataArr addObject:model];
                
                
                
                
                
            }
            
        }
        
        
        
        
        
        
        
        [mySelf.tableView reloadData];
        [self endRefreshing];
        
        
    }
     
     
     
     
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"下载失败");
              
          }];
    
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

-(void)endRefreshing {
    if (self.isRefreshing) {
        self.isRefreshing=NO;
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
    }
    if (self.isLoadMore) {
        self.isLoadMore=NO;
        [self.tableView footerEndRefreshing];
    }
}

-(void)creatRefreshView {
    
    __weak typeof (self)weakSelf=self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView  class] beginRefresh:^ {
        if (weakSelf.isRefreshing) {
            return ;
        }
        weakSelf.currentPage=3;
        weakSelf.isRefreshing=YES;
        [weakSelf loadDataPage:weakSelf.currentPage];
    }];
    
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore=YES;
        weakSelf.currentPage+=12;
        if (weakSelf.currentPage==10000) {
            weakSelf.currentPage=3;
        }
        [weakSelf loadDataPage:weakSelf.currentPage];
        
        
        
    }];
}












/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
