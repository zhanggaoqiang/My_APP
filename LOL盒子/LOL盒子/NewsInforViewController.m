//
//  NewsInforViewController.m
//  LOL盒子
//
//  Created by qianfeng on 15/8/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewsInforViewController.h"
#import "NewsInforModel.h"
#import "NewsInfroTableViewCell.h"
#import "AFNetworking.h"


@interface NewsInforViewController ()
{
    UIScrollView *_scroller;
    UIView *_view;
    NSArray *_arrUrl;
    NSString *_newUrl;
    UITableView *_tableView1;
    UITableView *_tableView2;
    UITableView *_tableView3;
    UITableView *_tableView4;

}








@property(nonatomic,strong)NSMutableArray *dataArr;


@end

@implementation NewsInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatHttpRequest];
    [self creatScrollView];
    self.isLoadMore = NO;
    self.isRefreshing = NO;
    self.currentPage = 1;
    
    
    
    [self creatSegment];
    
    
   
  
}





-(void)creatSegment {
    
    //事件驱动型
    NSArray *titles = @[@"小红",@"小黄",@"傻逼"];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:titles];
    seg.frame = CGRectMake(10, 100, 300, 30);
    //设置属性
    //设置默认选中的分段
    seg.selectedSegmentIndex = 0;
    
    
}





- (void)creatHttpRequest {
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _dataArr = [[NSMutableArray alloc] init];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsInfroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsInforCell" forIndexPath:indexPath];
    NewsInforModel *model = _dataArr[indexPath.row];
    [cell showDataWithModel:model];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
-(void)loadDataPage:(NSInteger)page {
//    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
//    [MMProgressHUD  showDeterminateProgressWithTitle:@"下载" status:@"Loading..."];
    
    
    // _newUrl =[NSString stringWithFormat:latestURL,self.currentPage];
    
    typeof(self) mySelf =self;
    [_manager GET:_newUrl parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        if (self.currentPage==1) {
            [self.dataArr removeAllObjects];
            
        }
        if (responseObject) {
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray *itemArr=dict[@"data"];
            
            for (NSDictionary *itemDict in itemArr) {
                NewsInforModel *model =[[NewsInforModel alloc] init];
                [model setValuesForKeysWithDictionary:itemDict];
                
                [mySelf.dataArr addObject:model];
            }
            [mySelf.tableView reloadData];
            
            
            
            //[MMProgressHUD dismissWithSuccess:@"恭喜" title:@"下载成功"];
            //[mySelf endRefreshing];
        }
        
    }
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"下载失败");
              //[mySelf endRefreshing];
              //[ MMProgressHUD dismissWithError:@"下载失败" title:@"警告"];
              
          }];
}

-(void)creatScrollView {
    NSArray *arr=@[@"最新",@"新闻",@"赛事",@"娱乐"];
    
    _scroller =[[UIScrollView alloc] initWithFrame:CGRectMake(0,94, kScreenSize.width, kScreenSize.height-94+49)];
    _scroller.backgroundColor=[UIColor greenColor];
    _scroller.contentSize=CGSizeMake(kScreenSize.width*4, kScreenSize.height);
    _scroller.bounces=NO;
    _scroller.showsVerticalScrollIndicator=NO;
    _scroller.showsHorizontalScrollIndicator=NO;
    _scroller.pagingEnabled=YES;
    
    
    [self.view addSubview:_scroller];
 }

-(void)viewWillAppear:(BOOL)animated {
    
 
    [self.view addSubview:_view];
    [self creatTableView1];
    [self creatTableView2];
    [self creatTableView3];
    [self creatTableView4];
    
}





-(void)creatTableView1 {
     _scroller.contentOffset=CGPointMake(0, 0);
    _newUrl =[NSString stringWithFormat:latestURL,self.currentPage];
    
    [self loadDataPage:self.currentPage];
    
    _tableView1= [[UITableView alloc] initWithFrame:CGRectMake(0, 0,  kScreenSize.width,_scroller.frame.size.height-49)];
    _tableView1.backgroundColor=[UIColor whiteColor];
    _tableView1.delegate=self;
    _tableView1.dataSource=self;
    
    _tableView1.showsHorizontalScrollIndicator=NO;
    _tableView1.showsVerticalScrollIndicator=NO;
    _tableView1.bounces=NO;
    _tableView1.backgroundColor=[UIColor greenColor];
    [_tableView1 registerNib:[UINib nibWithNibName:@"NewsInfroTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsInforCell"];
    [_scroller addSubview:_tableView1];
    
    
}

-(void)creatTableView2{
    _newUrl =[NSString stringWithFormat:newsURL,self.currentPage];
    
    [self loadDataPage:self.currentPage];
      _scroller.contentOffset=CGPointMake(kScreenSize.width, 0);
    _tableView2= [[UITableView alloc] initWithFrame:CGRectMake(kScreenSize.width, 0,  kScreenSize.width,_scroller.frame.size.height-49)];
    _tableView2.backgroundColor=[UIColor whiteColor];
    _tableView2.delegate=self;
    _tableView2.dataSource=self;
    
    _tableView2.showsHorizontalScrollIndicator=NO;
    _tableView2.showsVerticalScrollIndicator=NO;
    _tableView2.bounces=NO;
    _tableView2.backgroundColor=[UIColor greenColor];
    [_tableView2 registerNib:[UINib nibWithNibName:@"NewsInfroTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsInforCell"];
    [_scroller addSubview:_tableView2];
}

-(void)creatTableView3{
    _newUrl =[NSString stringWithFormat:matchURL,self.currentPage];
    
    [self loadDataPage:self.currentPage];
    
    
    _tableView3= [[UITableView alloc] initWithFrame:CGRectMake(kScreenSize.width*2, 0,  kScreenSize.width,_scroller.frame.size.height-49)];
    _tableView3.backgroundColor=[UIColor whiteColor];
    _tableView3.delegate=self;
    _tableView3.dataSource=self;
    
    _tableView3.showsHorizontalScrollIndicator=NO;
    _tableView3.showsVerticalScrollIndicator=NO;
    _tableView3.bounces=NO;
    _tableView3.backgroundColor=[UIColor greenColor];
    [_tableView3 registerNib:[UINib nibWithNibName:@"NewsInfroTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsInforCell"];
    [_scroller addSubview:_tableView3];
}




-(void)creatTableView4{
    _newUrl =[NSString stringWithFormat:pleaasntURL,self.currentPage];
    
    [self loadDataPage:self.currentPage];
    
    _tableView4= [[UITableView alloc] initWithFrame:CGRectMake(kScreenSize.width*3, 0,  kScreenSize.width,_scroller.frame.size.height-49)];
    _tableView4.backgroundColor=[UIColor whiteColor];
    _tableView4.delegate=self;
    _tableView4.dataSource=self;
    
    _tableView4.showsHorizontalScrollIndicator=NO;
    _tableView4.showsVerticalScrollIndicator=NO;
    _tableView4.bounces=NO;
    _tableView4.backgroundColor=[UIColor greenColor];
    [_tableView4 registerNib:[UINib nibWithNibName:@"NewsInfroTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsInforCell"];
    [_scroller addSubview:_tableView4];
    
    
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
