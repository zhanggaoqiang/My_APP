//
//  LOLBaseViewController.m
//  SeeNews
//
//  Created by qianfeng on 15/8/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LOLBaseViewController.h"
#import "GameModel.h"
#import "GameTableViewCell.h"
#import "JHRefresh.h"

@interface LOLBaseViewController ()




@end

@implementation LOLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor redColor];
    self.isLoadMore = NO;
    self.isRefreshing = NO;
    self.currentPage = 0;
    [self creatTableView];
    [self creatHttpRequest];
    [self loadDataPage:self.currentPage];
    [self creatRefreshView];
 
    
    // Do any additional setup after loading the view.
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
        weakSelf.currentPage=0;
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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-64-49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
  //  [self.tableView registerNib:[UINib nibWithNibName:@"GameTableViewCell" bundle:nil] forCellReuseIdentifier:@"PicCell"];
    [self.view addSubview:self.tableView];
    
}



- (void)creatHttpRequest {
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    
    //设置返回的格式 不让af 自动解析 返回二进制
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //创建数据源
    _dataArr = [[NSMutableArray alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PicCell" forIndexPath:indexPath];
    if (cell==nil) {
         cell = [[GameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PicCell"];
    }
    GameModel *model = _dataArr[indexPath.row];
    
    [cell showDataWithModel:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr count];
}

-(void)loadDataPage:(NSInteger)page {
    NSString *newUrl =[NSString stringWithFormat:latestURL,self.currentPage];
    
    typeof(self) mySelf =self;
    
    
    
    [_manager GET:newUrl parameters:nil success:^(AFHTTPRequestOperation *operation,
                                                  id responseObject){
        
        
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray *itemArr=dict[@"data"];
            
            for (NSDictionary *itemDict in itemArr) {
                GameModel *model =[[GameModel alloc] init];
                [model setValuesForKeysWithDictionary:itemDict];
                
                [mySelf.dataArr addObject:model];
                
                
            }
            [mySelf.tableView reloadData];
        [self endRefreshing];
        }
        
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"下载失败");
              
              
          }];
}











@end
