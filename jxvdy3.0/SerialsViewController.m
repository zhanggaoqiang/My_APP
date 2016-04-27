//
//  SerialsViewController.m
//  choutixiaoguo
//
//  Created by jxmm on 16/3/7.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "SerialsViewController.h"
#import "MJExtension.h"
#import "AllKindsOfVideoModel.h"
#import "VideoTableViewCell.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "RightViewController.h"
@interface SerialsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_videoTableView;
    NSInteger movieIndex;
    NSString *str1;
    NSInteger offset;
}
@end

@implementation SerialsViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:@"changeTag" object:nil];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    RightViewController *rightvc=[[RightViewController alloc] init];
    
    aNavigationItem=[[CustomNavigationItem alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64) showPerson:YES showFind:YES title:@"系列剧" rightButton:^(int tag){
        if (tag==100) {
            [self  presentViewController:rightvc animated:YES completion:nil];
        }
        
    }  kind:^(NSString *str) {
       
        
        str1=[NSString  stringWithFormat:@"http://api2.jxvdy.com/search_list?model=drama&order=time&count=15&offset=0&type=0"];
        
        
        [self  creatHttpRequest];
        [self  loadDataPage];
        [self loadDataPage];
    }];
    
    aNavigationItem.backgroundColor=[UIColor  orangeColor];
    aNavigationItem.navDelegate = self;
    [self.view addSubview:aNavigationItem];
    
    
    
    str1=[NSString  stringWithFormat:@"http://api2.jxvdy.com/search_list?model=drama&order=time&count=15&offset=0&type=0"];

    [self creatHttpRequest];
    [self loadDataPage];
    [self showUI];
    
    
   }

-(void)updateView {
    
    [_videoTableView reloadData];
}


-(void)endRefresh {
    
    [_videoTableView.mj_header  endRefreshing];
    [_videoTableView.mj_footer endRefreshing];
    
}




-(void)change:(NSNotification *)nf {
    
    
    movieIndex=([nf.userInfo[@"tag"]   integerValue]-200+28);
    if (movieIndex==28) {
        str1=[NSString  stringWithFormat:@"http://api2.jxvdy.com/search_list?model=drama&order=time&count=15&offset=0&type=0"];
    }
    
    
    str1=[NSString  stringWithFormat:@"http://api2.jxvdy.com/search_list?model=drama&order=time&count=15&offset=0&type=%ld",movieIndex];
    
    [self creatHttpRequest];
    [self loadDataPage];
    [self showUI];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super  viewWillDisappear:animated];
       
    [[NSNotificationCenter  defaultCenter] removeObserver:self];
    [[NSUserDefaults  standardUserDefaults] removeObjectForKey:@"movieIndex"];
    [[NSUserDefaults  standardUserDefaults] synchronize];
}




-(void)creatHttpRequest {
    _manager=[[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer=[AFHTTPResponseSerializer  serializer];
    self.dataArr=[[NSMutableArray alloc] init];
}
-(void)loadDataPage {
    [SVProgressHUD  show];
    
    NSString *str=[str1  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet   URLQueryAllowedCharacterSet]];
    [_manager  GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self endRefresh];
        NSArray *jsonString=[NSJSONSerialization  JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        self.dataArr=[AllKindsOfVideoModel  mj_objectArrayWithKeyValuesArray:jsonString];
        [_videoTableView reloadData];
        
        
        [SVProgressHUD  dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD  showErrorWithStatus:@"网络出错"];
        
    }];
}
-(void)showUI {
    _videoTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,self.view.frame.size.height-44)];
    _videoTableView.delegate=self;
    _videoTableView.dataSource=self;
    
    
    _videoTableView.mj_header=[MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        
        offset=(offset+1)*10;
        
        [self   loadDataPage];
        
    }];
    
    
    
    _videoTableView.mj_footer=[MJRefreshAutoFooter  footerWithRefreshingBlock:^{
        [self loadDataPage];
        
        
    }];
    //    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataPage)];
    //
    //    // 设置刷新图片
    //    [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
    //
    //    // 设置尾部
    //    self.tableView.mj_footer = footer;
    
    _videoTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_videoTableView];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 250;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellName = @"bookCell";
    //从复用队列中获取自定义的cell
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        //创建自定义的cell
        cell = [[VideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        //cell.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    //对cell 进行内容的修改  在{}进行
    //从数据源获取数据模型
    cell.backgroundColor=[UIColor colorWithRed:183/255.0 green:223/255.0 blue:208/255.0 alpha:1];
    AllKindsOfVideoModel *model=self.dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
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
