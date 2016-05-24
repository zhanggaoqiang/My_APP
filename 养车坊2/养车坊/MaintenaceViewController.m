//
//  MaintenaceViewController.m
//  养车坊
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MaintenaceViewController.h"
#import "DetailHeadViewController.h"
#import "AFNetworking.h"
#import "ServiceModel.h"
#import "CollectionViewCell.h"
#import "ViewController0.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ViewController5.h"
#import "ViewController6.h"
#import "ViewController7.h"
#import "ViewController8.h"
#import "ViewController9.h"
#import "ViewController10.h"
#import "ViewController11.h"
#import "ViewController12.h"
#import "ViewController13.h"
#import "Base1ViewController.h"
#import "JHRefresh.h"


#define CARBAIKE_URL @"http://api.tuhu.cn/Advertise/SelectAdvertiseNew?version=31&province=1&Platform=%d&city=%d"
#define kScreenSize [UIScreen mainScreen].bounds.size
@interface MaintenaceViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArr;
    NSArray *_ViewControllersArr;
    NSInteger _num;
    
}

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation MaintenaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.isLoadMore = NO;
    self.isRefreshing = NO;
    
    [self creatHttpRequest];
    [self loadDataPage];
    [self creatCollectionView];
    [self  creatRefreshView ];
  
}


-(void)endRefreshing {
    if (self.isRefreshing) {
        self.isRefreshing=NO;
        [self.collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
    }
    if (self.isLoadMore) {
        self.isLoadMore=NO;
        [self.collectionView footerEndRefreshing];
    }
    
    
}

-(void)creatRefreshView {
  
    __weak typeof (self)weakSelf=self;
    [self.collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView  class] beginRefresh:^ {
        if (weakSelf.isRefreshing) {
            return ;
        }
        weakSelf.isRefreshing=YES;
        [weakSelf loadDataPage];
    }];
    
    [self.collectionView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore=YES;
        [weakSelf loadDataPage];
        
        
        
    }];
}






-(void)creatCollectionView {
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(kScreenSize.width/2-5 ,100);
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    self.collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height) collectionViewLayout:layout];
    
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor=[UIColor orangeColor];
    //self.view.backgroundColor=[UIColor lightGrayColor];
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    switch (indexPath.row) {
        case 0:
            _num=95;
            break;
            
        case 1:
            _num=92;
            break;
            
        case 2:
            _num=91;
            break;
            
        case 3:
            _num=117;
            break;
            
        case 4:
            _num=119;
            break;
            
        case 5:
            _num=61;
            break;
            
        case 6:
            _num=16;
            break;
            
        case 7:
            _num=93;
            break;
            
        case 8:
            _num=17;
            break;
            
        case 9:
            _num=3;
            break;
            
        case 10:
            _num=94;
            break;
            
        case 11:
            _num=15;
            break;
            
        case 12:
            _num=99;
            break;
            
        case 13:
            _num=59;
            
            break;
            
        default:
            break;
    }

    _ViewControllersArr =[[NSArray alloc] init];
      _ViewControllersArr =@[@"ViewController0",@"ViewController1",@"ViewController2",@"ViewController3",@"ViewController4",@"ViewController5",@"ViewController6",@"ViewController7",@"ViewController8",@"ViewController9",@"ViewController10",@"ViewController11",@"ViewController12",@"ViewController13"];
    Class vcClass = NSClassFromString(_ViewControllersArr[indexPath.row]);
    Base1ViewController *bvc =[[vcClass alloc] init];
    bvc.index=_num;
  [self.navigationController pushViewController:bvc animated:YES];
    
}
- (void)creatHttpRequest {
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    
  
_manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    _dataArr = [[NSMutableArray alloc] init];
}





-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  _dataArr.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [_dataArr[section] count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell"forIndexPath:indexPath];
    cell.backgroundColor=[UIColor magentaColor];
    ServiceModel *model =_dataArr[indexPath.section][indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}



-(void)loadDataPage {
    NSMutableArray *arr=[[NSMutableArray alloc] init];
   
    NSString *newUrl =[NSString stringWithFormat:CARBAIKE_URL,1,1];
    
    __weak typeof(self) mySelf =self;
    [_manager GET:newUrl parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        [_dataArr removeAllObjects];
        
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray *itemArr=dict[@"Advertise"];
            
            for (NSDictionary *itemDict in itemArr[2]) {
               ServiceModel *model =[[ServiceModel alloc] init];
                
                model.icoimgurl =itemDict[@"icoimgurl"];
            
                [arr addObject:model];
    }
        [_dataArr addObject:arr];
        
        [mySelf.collectionView  reloadData];
        [mySelf endRefreshing];
}
     
     
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"下载失败");
              [mySelf endRefreshing];
              
          }];
}




















@end
