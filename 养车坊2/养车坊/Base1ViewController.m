//
//  Base1ViewController.m
//  养车坊
//
//  Created by qianfeng on 15/8/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Base1ViewController.h"

#import "BaseModel.h"
#import "BaseViewCell.h"
#define CARBAIKE_URL @"http://api.tuhu.cn/Advertise/SelectAdProductNew?ShowType=2&advertiseID=%ld"


#define kScreenSize [UIScreen mainScreen].bounds.size




@interface Base1ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArr;
    
}

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation Base1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.isLoadMore = NO;
    self.isRefreshing = NO;
    
    [self creatHttpRequest];
    [self loadDataPage];
    [self creatCollectionView];
    
    
    
    // Do any additional setup after loading the view.
}



-(void)creatCollectionView {
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(kScreenSize.width/2-5 ,230);
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    self.collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-20) collectionViewLayout:layout];
    
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.collectionView.backgroundColor=[UIColor greenColor];
    
    [self.collectionView registerClass:[BaseViewCell class] forCellWithReuseIdentifier:@"BaseViewCell"];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor=[UIColor lightGrayColor];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    //注册分区尾视图
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    
}
- (void)creatHttpRequest {
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    
    //设置返回的格式 不让af 自动解析 返回二进制
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //创建数据源
    _dataArr = [[NSMutableArray alloc] init];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  _dataArr.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_dataArr[section] count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BaseViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"BaseViewCell"forIndexPath:indexPath];
    cell.backgroundColor=[UIColor magentaColor];
    BaseModel *model =_dataArr[indexPath.section][indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}




-(void)loadDataPage {
    NSMutableArray *arr=[[NSMutableArray alloc] init];
//    Base1ViewController *bvc=[[Base1ViewController alloc] init];
//    _index=self.index;
    
    NSString *newUrl =[NSString stringWithFormat:CARBAIKE_URL,self.index];
    
    typeof(self) mySelf =self;
    [_manager GET:newUrl parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *itemArr=dict[@"AdProduct"];
        
        for (NSDictionary *itemDict in itemArr) {
            BaseModel *model =[[BaseModel alloc] init];
            
            model.DisplayName=itemDict[@"DisplayName"];
            model.Price=itemDict[@"Price"];
            model.Image=itemDict[@"Image"];
            model.RateNumber=(long)itemDict[@"RateNumber"];
            
            [arr addObject:model];
        }
        [_dataArr addObject:arr];
        
        [mySelf.collectionView  reloadData];
        self.isRefreshing=NO;
        [self.refreshControl endRefreshing];
        
        
    }
     
     
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"下载失败");
              
          }];
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
