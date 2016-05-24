//
//  ExploreViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ExploreViewController.h"
#import "HomeModel.h"
#import "JHRefresh.h"
#import "ExploreTableViewCell.h"
#import "DetailExploreControllerViewController.h"



@interface ExploreViewController ()
{
    NSMutableArray *_dataArr;
    
}
@property(nonatomic,strong)NSMutableArray *dataArr;




@end

@implementation ExploreViewController

- (void)viewDidLoad
{
    self.title = @"影视评论";
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailExploreControllerViewController *dvc=[[DetailExploreControllerViewController alloc] init];
    
    HomeModel *model=[[HomeModel alloc] init];
    model=_dataArr[indexPath.row];
    
    
    dvc.strid=model.id;
    [self.navigationController pushViewController:dvc animated:YES];
}




- (void)creatTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ExploreTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExploreCell"];
    [self.view addSubview:self.tableView];
}


- (void)creatHttpRequest {
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _dataArr = [[NSMutableArray alloc] init];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeModel *model =_dataArr[indexPath.row];
    
    
    
   ExploreTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ExploreCell" forIndexPath:indexPath];
    
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
    
    NSString *newUrl =[NSString stringWithFormat:kFindCommentUrl];
    
    
    __weak typeof(self) mySelf =self;
    [_manager GET:newUrl parameters:nil success:^(AFHTTPRequestOperation *operation,
                                                  id responseObject){
        
        if (self.currentPage==1) {
            [self.dataArr removeAllObjects];
            
        }
        if (responseObject) {
            
            NSArray *itemArr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
      
            
            
            for (NSDictionary *itemDict in itemArr) {
                HomeModel *model =[[HomeModel alloc] init];
                model.image=itemDict[@"relatedObj"][@"image"];
                model.username=itemDict[@"userImage"];
                model.nickname=itemDict[@"nickname"];
                model.title=itemDict[@"title"];
                model.summary=itemDict[@"summary"];
                
                
                
               // [model setValuesForKeysWithDictionary:itemDict];
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

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
