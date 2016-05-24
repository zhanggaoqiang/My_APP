//
//  CarKnologyViewController.m
//  养车坊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CarKnologyViewController.h"
#import "PicCell.h"
#import "DetailHeadViewController.h"

#define kScreenSize [UIScreen mainScreen].bounds.size



#define CARBAIKE_URL @"http://huodong.tuhu.cn/Advertise/SelectArticle.html?pindex=%ld&Category=%d"


@interface CarKnologyViewController ()

@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation CarKnologyViewController

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
    [self creatPullUpView];
    
    
    
    
    // Do any additional setup after loading the view.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell被选中");
    DetailHeadViewController *dvc=[[DetailHeadViewController alloc] init];
    VehicleMaintenanceModel *model  = _dataArr[indexPath.row];
    
    dvc.str = model.ContentUrl;
    
    
    [self.navigationController pushViewController:dvc animated:YES];
}


- (void)creatTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"PicCell" bundle:nil] forCellReuseIdentifier:@"PicCell"];
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
    PicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PicCell" forIndexPath:indexPath];
    VehicleMaintenanceModel *model = _dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 230;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


-(void)creatRefreshView{
    self.refreshControl=[[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor=[UIColor orangeColor];
    self.refreshControl.tintColor=[UIColor lightGrayColor];
    self.refreshControl.attributedTitle=[[NSAttributedString alloc] initWithString:@"下拉即可刷新"];
    [self.refreshControl addTarget:self action:@selector(refreshControlClick:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    [self.tableView sendSubviewToBack:self.refreshControl];
}
-(void)refreshControlClick:(UIRefreshControl*)refresh{
    if (self.isRefreshing) {
        return;
    }
    self.isRefreshing=YES;
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手即可刷新"];
    self.currentPage=0;
    
    [self loadDataPage:self.currentPage];
}

-(void)creatPullUpView{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(0, 0, self.tableView.bounds.size.width, 30);
    [button setTitle:@"点击加载更多" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = button;
    
}
- (void)btnClick:(UIButton *)button {
    if (self.isRefreshing) {
        return;
    }
    self.isRefreshing = YES;
    self.currentPage ++;//页码+1
    
    
    [self loadDataPage:self.currentPage];
}




-(void)loadDataPage:(NSInteger)page {
      NSString *newUrl =[NSString stringWithFormat:CARBAIKE_URL,self.currentPage,1];
    
    typeof(self) mySelf =self;
    [_manager GET:newUrl parameters:nil success:^(AFHTTPRequestOperation *operation,
                                                  id responseObject){
        
        if (self.currentPage==0) {
            [self.dataArr removeAllObjects];
            
        }
        if (responseObject) {
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray *itemArr=dict[@"Article"];
            
            for (NSDictionary *itemDict in itemArr) {
                VehicleMaintenanceModel *model =[[VehicleMaintenanceModel alloc] init];
                [model setValuesForKeysWithDictionary:itemDict];
                
                [mySelf.dataArr addObject:model];
                
                
            }
            [mySelf.tableView reloadData];
            self.isRefreshing=NO;
            [self.refreshControl endRefreshing];
        }
        
    }
     
     
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"下载失败");
              
          }];
}









@end
