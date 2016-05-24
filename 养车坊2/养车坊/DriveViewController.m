//
//  DriveViewController.m
//  养车坊
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DriveViewController.h"
#import "CarNewsViewController.h"
#import "AFNetworking.h"

#import "NewsCell.h"
#import "DetailHeadViewController.h"
#import "TopicModel.h"
#import "JHRefresh.h"
#import "MMProgressHUD.h"

#define kScreenSize [UIScreen mainScreen].bounds.size



#define CARBAIKE_URL @"http://a.xcar.com.cn/interface/6.0/getNewsList.php?type=2&cityId=&offset=%d&limit=%d&ver=6.1.3.2"

@interface DriveViewController ()

@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation DriveViewController

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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CarNewsViewController *dvc=[[CarNewsViewController alloc] init];
   TopicModel *model  = _dataArr[indexPath.row];
    dvc.str = model.newsLink;
     
    [self.navigationController pushViewController:dvc animated:YES];
}


- (void)creatTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-44-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"NewsCellD"];
    [self.view addSubview:self.tableView];
    
}
- (void)creatHttpRequest {
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _dataArr = [[NSMutableArray alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCellD" forIndexPath:indexPath];
    TopicModel *model = _dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}



-(void)loadDataPage:(NSInteger)page {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
    [MMProgressHUD  showDeterminateProgressWithTitle:@"下载" status:@"Loading..."];
    
    
    
      NSString *newUrl =[NSString stringWithFormat:CARBAIKE_URL,self.currentPage*10,10];
    
    typeof(self) mySelf =self;
    [_manager GET:newUrl parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
            if (self.currentPage==1) {
            [self.dataArr removeAllObjects];
            
        }
        if (responseObject) {
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray *itemArr=dict[@"newsList"];
            
            for (NSDictionary *itemDict in itemArr) {
                TopicModel *model =[[TopicModel alloc] init];
                [model setValuesForKeysWithDictionary:itemDict];
                
                [mySelf.dataArr addObject:model];
            }
            [mySelf.tableView reloadData];
          
            
            
           [MMProgressHUD dismissWithSuccess:@"恭喜" title:@"下载成功"];
            [mySelf endRefreshing];
        }
        
    }
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"下载失败");
               [mySelf endRefreshing];
             [ MMProgressHUD dismissWithError:@"下载失败" title:@"警告"];
              
          }];
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
