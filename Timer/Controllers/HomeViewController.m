//
//  HomeViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeModel.h"
#import "HomeTableViewCell.h"
#import "JHRefresh.h"
#import "HomeTableViewCell1.h"
#import "ADView.h"
#import "MainlandListViewController.h"
#import "AllNationalViewController.h"

@interface HomeViewController ()
{
 NSMutableArray *_dataArr;
  int flag;
    
    
    ADView *_view11;
}
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)ADView *view11;
@end





@implementation HomeViewController

- (void)viewDidLoad
{
    self.title = @"新闻";
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
    

        [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"PicCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell1" bundle:nil] forCellReuseIdentifier:@"PicCell1"];
    
     [self.view addSubview:self.tableView];
    self.view11 =[[ADView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 190)];
    
    
    __weak typeof (self) weakself=self;
    self.tableView.tableHeaderView=self.view11;
    MainlandListViewController *mvc=[[MainlandListViewController alloc] init];
    [self.view11 setAdClick:^(void) {
        
        [weakself.navigationController pushViewController:mvc animated:YES];
        
        
    }
     
     
     ];
    
    
    AllNationalViewController *mvc1=[[AllNationalViewController alloc] init];
    [self.view11 setAdClick1:^(void) {
        
        [weakself.navigationController pushViewController:mvc1 animated:YES];
        
        
    }
     
     
     ];
    
}

- (void)creatHttpRequest {
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _dataArr = [[NSMutableArray alloc] init];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     HomeModel *model =_dataArr[indexPath.row];
    if (model.url1.length == 0) {
       
        
        HomeTableViewCell1 *cell =[tableView dequeueReusableCellWithIdentifier:@"PicCell1" forIndexPath:indexPath];
        
        [cell showDataWithModel:model];
        return cell;
        

    }else {

        HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PicCell" forIndexPath:indexPath];
        
        [cell showDataWithModel:model];
    return cell;
    }
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *model =_dataArr[indexPath.row];
    if (model.url1.length == 0) {
        
        return 120;
        
    }
    
    
    return 150;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(void)loadDataPage:(NSInteger)page {

    NSString *newUrl =[NSString stringWithFormat:NEWS__URL,self.currentPage];
    
    
    __weak typeof(self) mySelf =self;
    [_manager GET:newUrl parameters:nil success:^(AFHTTPRequestOperation *operation,
                                                  id responseObject){
        
        if (self.currentPage==1) {
            [self.dataArr removeAllObjects];
            
        }
        if (responseObject) {
            
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *itemArr=dict[@"newsList"];
            
       
            for (NSDictionary *itemDict in itemArr) {
                HomeModel *model =[[HomeModel alloc] init];
                model.title=itemDict[@"title"];
                model.title2=itemDict[@"title2"];
               // model.commentCount=itemDict[@"commentCount"];
                 
                
                if ( [itemDict[@"images"] count]==0 ) {
                    
                    
                    model.image=itemDict[@"image"];
                    [self.dataArr addObject:model];
                
             
                }else {
                    model.url1=itemDict[@"images"][0][@"url1"];
                    model.url2=itemDict[@"images"][1][@"url1"];
                   // model.url3=itemDict[@"images"][2][@"url1"];
                    [self.dataArr addObject:model];
                }
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




