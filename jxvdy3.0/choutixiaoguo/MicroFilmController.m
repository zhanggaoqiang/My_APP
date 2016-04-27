//
//  LeftVC2.m
//  choutixiaoguo
//
//  Created by jxmm on 16/1/13.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "MicroFilmController.h"
#import "MJExtension.h"
#import "AllKindsOfVideoModel.h"
#import "VideoTableViewCell.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "JHRefresh.h"
#import "MMProgressHUD.h"
#import "RightViewController.h"
#import "DetailVideoViewController.h"
#import "ShareView.h"

@interface MicroFilmController ()<UITableViewDataSource,UITableViewDelegate>
{
    //UITableView *_videoTableView;
    NSInteger movieIndex;
    NSString *str1;
    NSInteger movieCount;
    NSInteger loadCount;
    NSString *countStr;
}

@end

@implementation MicroFilmController


-(void)viewWillAppear:(BOOL)animated {
    
    [super  viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:@"changeTag" object:nil];
 
}


-(void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeTag" object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    RightViewController *rightvc=[[RightViewController alloc] init];
    
    aNavigationItem=[[CustomNavigationItem alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64) showPerson:YES showFind:YES title:@"微电影" rightButton:^(int tag){
                if (tag==100) {
              [self  presentViewController:rightvc animated:YES completion:nil];
                }
          
    }  kind:^(NSString *str) {
       
        movieCount=5;
        countStr=[[NSString alloc] initWithString:str];
         str1=[NSString  stringWithFormat:@"http://api2.jxvdy.com/search_list?model=video&order=%@&count=5&offset=0&type=0",countStr];
        
        [self creatTableView];
        [self creatRefreshView];
        [self loadDataPage];
    }];
    
    aNavigationItem.backgroundColor=[UIColor  orangeColor];
    aNavigationItem.navDelegate = self;
    [self.view addSubview:aNavigationItem];

      movieCount=5;
      _manager=[[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer=[AFHTTPResponseSerializer  serializer];
    self.dataArr=[[NSMutableArray alloc] init];
        self.isRefreshing = NO;
      self.automaticallyAdjustsScrollViewInsets=NO;
    
    //hits,like
    
    loadCount=[[[NSUserDefaults standardUserDefaults] objectForKey:@"movieIndex"] integerValue]-100;
    
    [self creatTableView];
  [self creatRefreshView];
    
    str1=[NSString  stringWithFormat:@"http://api2.jxvdy.com/search_list?model=video&order=%@&count=%ld&offset=0&type=0", countStr, movieCount];
    
    [self loadDataPage];
     
  }


-(void)viewWillDisappear:(BOOL)animated {
    [super  viewWillDisappear:animated];
 
    
    [[NSNotificationCenter  defaultCenter] removeObserver:self];
    [[NSUserDefaults  standardUserDefaults] removeObjectForKey:@"movieIndex"];
    [[NSUserDefaults  standardUserDefaults] synchronize];
    
    
}



#pragma mark - 刷新

- (void)creatRefreshView {
    __weak typeof(self) weakSelf = self;
    
    [_videoTableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefreshing) {
            return ;
        }
        movieCount=5;
        weakSelf.isRefreshing = YES;
          [weakSelf loadDataPage];
        
         [weakSelf.videoTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
       
    }];
    
    [_videoTableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        //上拉加载更多
        if (weakSelf.isLoadMoring) {
            return ;
        }
        weakSelf.isLoadMoring = YES;
        movieCount+=5;
      //        
        str1=[NSString  stringWithFormat:@"http://api2.jxvdy.com/search_list?model=video&order=%@&count=%ld&offset=0&type=0",countStr, movieCount];
        [weakSelf loadDataPage];
        
        [weakSelf.videoTableView footerEndRefreshing];
        
    }];
    
    
}
-(void)change:(NSNotification *)nf {
    movieCount=5;
     movieIndex=([nf.userInfo[@"tag"]   integerValue]-100);
    loadCount=movieIndex;
    str1=[NSString  stringWithFormat:@"http://api2.jxvdy.com/search_list?model=video&order=%@&count=%ld&offset=0&type=%ld",countStr, movieCount,movieIndex];

    [self creatTableView];
    [self creatRefreshView];
    [self loadDataPage];
}


-(void)loadDataPage {
    [MMProgressHUD  setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:@"下载" status:@"Loading..."];
    NSString *str=[str1  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet   URLQueryAllowedCharacterSet]];
    [_manager  GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *jsonString=[NSJSONSerialization  JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        self.dataArr=[AllKindsOfVideoModel  mj_objectArrayWithKeyValuesArray:jsonString];
        
            
        NSLog(@"%@",jsonString);
         [_videoTableView reloadData];
      
        
        [MMProgressHUD dismissWithSuccess:@"恭喜" title:@"加载完成"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       [MMProgressHUD dismissWithError:@"下载失败" title:@"警告"];
        
    }];
}
-(void)creatTableView {
    _videoTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,self.view.frame.size.height-64)];
    _videoTableView.delegate=self;
    _videoTableView.dataSource=self;
    
    _videoTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_videoTableView];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DetailVideoViewController *detailVC=[[DetailVideoViewController alloc] init];
    AllKindsOfVideoModel *model=[[AllKindsOfVideoModel alloc ] init];
    model=self.dataArr[indexPath.row];
    detailVC.movieID=model.id;
    NSLog(@"model.movieID:%@",model.id);
    [self  presentViewController:detailVC animated:YES completion:nil];
    
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
//        cell = [[VideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        
        cell=[[VideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName BlcokBtn:^(int tag) {
           
            if (tag==111) {
                NSLog(@"执行block");
                
                [self creatShareView];
        }
        }];
        //cell.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    //对cell 进行内容的修改  在{}进行
    //从数据源获取数据模型
    cell.backgroundColor=[UIColor colorWithRed:183/255.0 green:223/255.0 blue:208/255.0 alpha:1];
    AllKindsOfVideoModel *model=self.dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}


-(void)creatShareView {
    __weak  MicroFilmController *weakSelf=self;
    
   __block  ShareView *sharview= [[ShareView alloc] initWithFrame:CGRectMake(0, kScreenSize.height-250, kScreenSize.width, 250) shareItem:^(int  index) {
           
       [UIView   animateWithDuration:.5 animations:^{
           sharview.frame=CGRectMake(0, weakSelf.view.frame.size.height, kScreenSize.width, 250);
           
       }];
       
       if (index==6) {
           return;
       }
    }];
    
    [self.view  addSubview:sharview];
}


@end
