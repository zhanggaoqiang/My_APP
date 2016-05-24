//
//  MainlandListViewController.m
//  Timer
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MainlandListViewController.h"
#import "HomeModel.h"
#import "MainlandTableViewCell.h"
#import "JHRefresh.h"

@interface MainlandListViewController ()

{
    NSMutableArray *_dataArr;
 
}
@property(nonatomic,strong)NSMutableArray *dataArr;




@end

@implementation MainlandListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MainlandTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainlandCell"];
    
    [self.view addSubview:self.tableView];
    
}


- (void)creatHttpRequest {
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _dataArr = [[NSMutableArray alloc] init];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeModel *model =_dataArr[indexPath.row];
    
      MainlandTableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:@"MainlandCell" forIndexPath:indexPath];
        
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
    
    
    
    __weak typeof(self) mySelf =self;
    [_manager GET:NATIVEURL parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
               if (responseObject) {
            
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *itemArr=dict[@"movies"];
            
            
            for (NSDictionary *itemDict in itemArr) {
                HomeModel *model =[[HomeModel alloc] init];
                model.posterUrl=itemDict[@"posterUrl"];
                
                
                
                
                [model setValuesForKeysWithDictionary:itemDict];
                
                [_dataArr addObject:model];
                
            }
        }
        
        [mySelf.tableView reloadData];
        [self endRefreshing];
        
    }
        failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"下载失败");
              
          }];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
