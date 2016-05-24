//
//  ActivityViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ActivityViewController.h"
#import "HomeModel.h"
#import "JHRefresh.h"
#import "ActivityTableViewCell.h"




@interface ActivityViewController ()

{
    NSMutableArray *_dataArr;
 
}
@property(nonatomic,strong)NSMutableArray *dataArr;




@end

@implementation ActivityViewController

- (void)viewDidLoad
{
    self.title = @"预告片";
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor redColor];
    
    self.isLoadMore = NO;
    self.isRefreshing = NO;
    self.currentPage = 1;
    [self creatTableView];
    [self creatHttpRequest];
    [self loadDataPage:self.currentPage];
    [self creatRefreshView];
    
    
    
    
    

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
        weakSelf.currentPage=1;
        weakSelf.isRefreshing=YES;
        [weakSelf loadDataPage:weakSelf.currentPage];
    }];
    
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore=YES;
        weakSelf.currentPage++;
        [weakSelf loadDataPage:weakSelf.currentPage];
        
        
        
    }];
}


- (void)creatTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"ACtiveCell"];
       [self.view addSubview:self.tableView];
   }


- (void)creatHttpRequest {
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _dataArr = [[NSMutableArray alloc] init];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeModel *model =_dataArr[indexPath.row];
  
        
        
       ActivityTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ACtiveCell" forIndexPath:indexPath];
        
        [cell showDataWithModel:model];
        return cell;
        
        
   }




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(void)loadDataPage:(NSInteger)page {
    
    NSString *newUrl =[NSString stringWithFormat:kForeDisplayUrl];
    
    
    __weak typeof(self) mySelf =self;
    [_manager GET:newUrl parameters:nil success:^(AFHTTPRequestOperation *operation,
                                                  id responseObject){
        
        if (self.currentPage==1) {
            [self.dataArr removeAllObjects];
            
        }
        if (responseObject) {
            
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *itemArr=dict[@"trailers"];
            
            
            for (NSDictionary *itemDict in itemArr) {
                HomeModel *model =[[HomeModel alloc] init];
              
                
                
                [model setValuesForKeysWithDictionary:itemDict];
                    [self.dataArr addObject:model];
                    
                    }
        }
        
        [mySelf.tableView reloadData];
        [self endRefreshing];
        
    }
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"下载失败");
              
          }];
}










@end

