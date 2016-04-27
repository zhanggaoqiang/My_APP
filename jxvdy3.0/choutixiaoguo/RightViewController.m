//
//  RightViewController.m
//  choutixiaoguo
//
//  Created by jxmm on 16/1/13.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "RightViewController.h"
#import "PersonalCenterCollectionViewCell.h"
#import "PersonalCenterModel.h"
#import "Masonry.h"
#import "LoginViewController.h"
#import "AccountSettingViewController.h"

@interface RightViewController()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
      NSMutableArray *_dataArr;

    
}
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property(nonatomic,strong)UILabel *nickLabel;

@end


@implementation RightViewController


- (void)creatBackButton {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=GRAY_BACK;
   
    _manager=[[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer=[AFHTTPResponseSerializer serializer];
   
    [self creatView];
    
    [self dataInit];
    
    [self creatHeadView];
 
}


-(void)login {
    LoginViewController *lovc=[[LoginViewController alloc] init];
    [self   presentViewController:lovc animated:YES completion:nil];
    
}



-(void)creatHeadView {
//    NSDictionary *dict=@{
//                         @"id":[[NSUserDefaults standardUserDefaults] objectForKey:@"id"],
//                         @"token":[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]
//                         
//                         };
    
    
    
    

    
    
    
    
    
    UIView *headView=[[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height/3-20)];
  
    [self.view addSubview:headView];
    headView.backgroundColor=PERSONAL_CENTER_COLOR;
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.selected=NO;
    button.frame=CGRectMake(0, 0, 40, 100);
      
   // [button setTitle:@"我的" forState:UIControlStateNormal];
    button.titleLabel.textAlignment=NSTextAlignmentRight;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [headView addSubview:button];
    
    
    UILabel *mylabel=[[UILabel alloc] initWithFrame:CGRectMake(25, 10, 50, 25)];
    mylabel.text=@"我的";
    mylabel.textColor=[UIColor whiteColor];
    [button addSubview:mylabel];
    
    UIImageView *imageBack=[[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 25, 25)];
   imageBack.image=[UIImage imageNamed:@"返回"];
    [button  addSubview:imageBack];

    
    [button  addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *button1= [UIButton buttonWithType:UIButtonTypeCustom];
    
    button1.selected=NO;
    button1.frame=CGRectMake(headView.frame.size.width/2-50,headView.frame.size.height/2-50, 100, 120);
  //  [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  //  button1.backgroundColor=[UIColor blackColor];
    [headView addSubview:button1];
    [button1  addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView=[UIImageView new];
    
  
    imageView.image=[UIImage  imageNamed:@"个人中心"];
    
    
   
    
    imageView.backgroundColor=[UIColor whiteColor];
    imageView.layer.masksToBounds=YES;
    imageView.layer.cornerRadius=50;
    [button1  addSubview:imageView];
    
    self.nickLabel=[UILabel new];
    self.nickLabel.text=@"注册/登录";
    self.nickLabel.textAlignment=NSTextAlignmentCenter;
    [button1 addSubview:self.nickLabel];
    
    
    [imageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(button1.mas_left).offset(0);
        make.right.mas_equalTo(button1.mas_right).offset(0);
        make.top.mas_equalTo(button1.mas_top).offset(0);
        make.bottom.mas_equalTo(button1.mas_bottom).offset(-20);
        
    }];
    
    [self.nickLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(button1.mas_left).offset(0);
        make.right.mas_equalTo(button1.mas_right).offset(0);
        make.top.mas_equalTo(imageView.mas_bottom).offset(5);
        make.bottom.mas_equalTo(button1.mas_bottom).offset(0);
    }];
}

-(void)btnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dataInit {
    _dataArr=[[NSMutableArray alloc] init];
    NSArray *titlearr=@[@"我的作品",@"我的关注",@"播放记录",@"账户设置",@"我的下载",@"我的好友"];
    NSArray *imageArr=@[@"我的作品",@"我的关注",@"播放记录",@"账户设置",@"我的下载",@"我的好友"];
    
    for (NSInteger i=0; i<6; i++) {
        PersonalCenterModel *model=[[PersonalCenterModel alloc] init];
        model.contentStr=[NSString stringWithFormat:@"%@",titlearr[i]];
        model.imageName=imageArr[i];
        
        [_dataArr  addObject:model];
    }
    [self.collectionView  reloadData];
}

-(void)creatView {
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(self.view.frame.size.width/3-0.5, self.view.frame.size.height/6);
    layout.sectionInset=UIEdgeInsetsMake(0,0,0,0);
   layout.minimumInteritemSpacing=0.5;
    layout.minimumLineSpacing=0.5;
     
       //layout.headerReferenceSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height/3);
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/3, self.view.frame.size.width, self.view.frame.size.height-20) collectionViewLayout:layout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView registerClass:[PersonalCenterCollectionViewCell class] forCellWithReuseIdentifier:@"PersonalCenterCollectionViewCell"];
    
    
    self.collectionView.backgroundColor=GRAY_BACK;
   
    [self.view  addSubview:self.collectionView];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PersonalCenterCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"PersonalCenterCollectionViewCell" forIndexPath:indexPath];
    PersonalCenterModel *model=_dataArr[indexPath.row];
    cell.backgroundColor=[UIColor whiteColor];
    [cell showDataWithModel:model];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            
            
            
        }
        
            break;
            
            
        case 1:{
            
            
            
        }
            
            break;
            
        case 2:{
            
        }
            
            break;
            
        case 3:{
            AccountSettingViewController *acout=[[AccountSettingViewController alloc] init];
            [self presentViewController:acout animated:YES completion:nil];
            
            
        }
            
            break;
            
        case 4:{
            
        }
            
            break;
            
        case 5:{
            
            
            
        }
            
            break;
            
            
            
            
            
        default:
            break;
    }
    
    
}



//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(self.view.frame.size.width/3, self.view.frame.size.height/6);
//    
//}







@end
