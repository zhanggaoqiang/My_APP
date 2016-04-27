//
//  ScriptViewController.m
//  choutixiaoguo
//
//  Created by jxmm on 16/3/4.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "ScriptViewController.h"
#import "FindScriptCell.h"
#import "FindScriptModel.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "CustomNavigationItem.h"
#import "RightViewController.h"


@interface ScriptViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_videoTableView;
    NSInteger movieIndex;
    NSString *str1;
    NSInteger offset;
    
}

@end

@implementation ScriptViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:@"changeTag" object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    RightViewController *rightvc=[[RightViewController alloc] init];
    
    aNavigationItem=[[CustomNavigationItem alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64) showPerson:YES showFind:YES title:@"找剧本" rightButton:^(int tag){
        if (tag==100) {
            [self  presentViewController:rightvc animated:YES completion:nil];
        }
        
    }  kind:^(NSString *str) {
        NSLog(@"执行了block,str=%@",str);
        
            str1=[NSString  stringWithFormat:@"http://api2.jxvdy.com/search_list?model=screenplay&order=time&count=15&offset=0&type=0"];
        
        
        [self  creatHttpRequest];
        [self  loadDataPage];
        [self loadDataPage];
    }];
    
    aNavigationItem.backgroundColor=[UIColor  orangeColor];
    aNavigationItem.navDelegate = self;
    [self.view addSubview:aNavigationItem];
    
    
    
//    str1=[NSString  stringWithFormat:@"http://api2.jxvdy.com/search_list?model=screenplay&order=time&count=15&type=%ld&sale=0&offset=0",[[[NSUserDefaults  standardUserDefaults] objectForKey:@"movieIndex"]  integerValue]-300];
    
    str1=[NSString  stringWithFormat:@"http://api2.jxvdy.com/search_list?model=screenplay&order=time&count=15&type=0&sale=0&offset=0"];


    [self creatHttpRequest];
    [self loadDataPage];
    [self showUI];
    
    
   
    
     }

-(void)updateView {
    
    [_videoTableView reloadData];
}



-(void)change:(NSNotification *)nf {
    
    //[_videoTableView  removeFromSuperview];
    movieIndex=([nf.userInfo[@"tag"]   integerValue]-300+41);
    if (movieIndex==41) {
        str1=[NSString  stringWithFormat:@"http://api2.jxvdy.com/search_list?model=screenplay&order=time&count=15&type=0&sale=0&offset=0"];
 
    }
    else {
    str1=[NSString  stringWithFormat:@"http://api2.jxvdy.com/search_list?model=screenplay&order=time&count=15&type=%ld&sale=0&offset=0",(long)movieIndex];
    }
    
    [self creatHttpRequest];
    [self loadDataPage];
    [self showUI];
}


-(void)dealloc {
    [[NSNotificationCenter  defaultCenter] removeObserver:self];
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
        
      
        NSArray *arr=[NSJSONSerialization  JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dict是:%@",arr);
        
        for (NSDictionary *dict in arr) {
            
            FindScriptModel *model=[[FindScriptModel alloc] init];
            model.description1=dict[@"description"];
            
            model.idScript=dict[@"id"];
            model.img=dict[@"img"];
            model.price=dict[@"price"];
            model.time=dict[@"time"];
            model.title=dict[@"title"];
    [self.dataArr  addObject:model];
        }//
        //self.dataArr=[FindScriptModel mj_objectArrayWithKeyValuesArray:jsonString];
        
        
        
        
    
        
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
    
    
    
    
    
 
    //    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataPage)];
    //
    //    // 设置刷新图片
    //    [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
    //
    //    // 设置尾部
    //    self.tableView.mj_footer = footer;
  }


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellName = @"bookCell";
    //从复用队列中获取自定义的cell
    FindScriptCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        //创建自定义的cell
        cell = [[FindScriptCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        //cell.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    //对cell 进行内容的修改  在{}进行
    //从数据源获取数据模型
    cell.backgroundColor=[UIColor colorWithRed:183/255.0 green:223/255.0 blue:208/255.0 alpha:1];
    FindScriptModel *model=self.dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
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
