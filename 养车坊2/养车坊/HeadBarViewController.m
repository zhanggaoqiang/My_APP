//
//  HeadBarViewController.m
//  养车坊
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HeadBarViewController.h"
#import "VehicleMaintenanceModel.h"
#import "PicCell.h"
#import "DetailHeadViewController.h"
#import "ClassificationViewController.h"
#import "DDMenuController.h"

#import "JHRefresh.h"



#define kScreenSize [UIScreen mainScreen].bounds.size

#define CONTENTS_URL @"http://huodong.tuhu.cn/Advertise/SelectArticle.html?pindex=%d"

@interface HeadBarViewController ()

@property(nonatomic,strong)NSMutableArray *dataArr;

//@synthesize menuController = _menuController;

@end

@implementation HeadBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self creatButtonBarItem];
    self.isLoadMore = NO;
    self.isRefreshing = NO;
    self.currentPage = 0;
    [self creatTableView];
    [self creatHttpRequest];
    [self loadDataPage:self.currentPage];
    [self creatRefreshView];
  

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







-(void)creatButtonBarItem {
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"bt_left"] forState:UIControlStateNormal];
    //[button setTitle:@"分类" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=item;
    
}

-(void)btnClick1:(UIButton *)btn {
    
    
//    DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:self];
//    _menuController= rootController;
//    
//    ClassificationViewController *leftController = [[ClassificationViewController alloc] init];
//    rootController.leftViewController = leftController;
//    
    
    
    ClassificationViewController *cvc =[[ClassificationViewController alloc] init];
    [self.navigationController pushViewController:cvc animated:YES];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailHeadViewController *dvc=[[DetailHeadViewController alloc] init];
    VehicleMaintenanceModel *model  = _dataArr[indexPath.row];

    dvc.str = model.ContentUrl;
    
    [self.navigationController pushViewController:dvc animated:YES];
}
- (void)creatTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-44-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"PicCell" bundle:nil] forCellReuseIdentifier:@"PicCell"];
    [self.view addSubview:self.tableView];
    
}
- (void)creatHttpRequest {
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
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

-(void)loadDataPage:(NSInteger)page {
    
    NSString *newUrl =[NSString stringWithFormat:CONTENTS_URL,self.currentPage];
   
   
    __weak typeof(self) mySelf =self;
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
            [self endRefreshing];
            
          
        }
        
    }
                                                 
                                                 
   failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        NSLog(@"下载失败");
    
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
