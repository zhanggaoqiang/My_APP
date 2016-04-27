//
//  AccountSettingViewController.m
//  choutixiaoguo
//
//  Created by jxmm on 16/3/22.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "AccountSettingViewController.h"
#import "CustomPopNavigation.h"
#import "SVProgressHUD.h"
#import "EditDataCell.h"

#import "ZGQHelp.h"

@interface AccountSettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

{
    UIButton *button1;
    UIView *view;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    
}

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation AccountSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=GRAY_BACK;
    
    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [self customPopView];
    [self dataInit];
    [self creatTableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changMembername:) name:@"123" object:nil];
    button1=[[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width/2-100, kScreenSize.height/2+50, 200, 50)];
    [button1 setTitle:@"退出登录" forState:UIControlStateNormal];
    button1.backgroundColor=[UIColor lightGrayColor];
    [button1 addTarget:self action:@selector(quitLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    if ([[NSUserDefaults  standardUserDefaults] objectForKey:@"token"]) {
        button1.hidden=NO;
    }
    else {
        button1.hidden=YES;
    }
    view=[[UIView alloc] initWithFrame:CGRectMake(kScreenSize.width/2-100, kScreenSize.height/2+100, 200, 100)];
    view.backgroundColor=[UIColor blackColor];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/2-50, view.frame.size.height/2-20, 100, 40)];
    label.text=@"退出登录";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    [self.view addSubview:view];
    view.layer.cornerRadius=50.0f;
    view.alpha=0;
    
   }

-(void)dataInit {
    
    _dataArr =[[NSMutableArray alloc] init];
    NSArray *arr= [NSMutableArray arrayWithObjects:@[@"清除缓存"],nil];
    [_dataArr addObjectsFromArray:arr];
    [self.tableView reloadData];
    
}

-(void)creatTableView {
    //self.automaticallyAdjustsScrollViewInsets=NO;
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,100, kScreenSize.width, kScreenSize.height/4) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=GRAY_BACK;
    self.tableView.scrollEnabled=NO;
    [self.view addSubview:self.tableView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row=indexPath.row;
    switch (indexPath.section) {
            
        case 0:
            
            [self sectionAction:row];
            break;
            
        default:
            break;
            
    }
}

-(void)sectionAction:(NSInteger)row{
    switch (row) {
        case 0: {
            UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"确定清除缓存%.2fM",[self getCashSize]] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
            sheet.delegate=self;
            [sheet showInView:self.view];
            
        }
            break;
            
        default:
            break;
            
    }
    
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        [self removeCashData];
    } else{
        
    }
    
}


-(void)removeCashData {
    
    [[SDImageCache sharedImageCache]clearDisk];
    
    
}

-(double)getCashSize {
    SDImageCache *cash =[SDImageCache sharedImageCache];
    NSUInteger fileSize =[cash getSize];
    NSString *path =[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Cashes/MyCaches"];
    
    NSFileManager *filemaneger =[NSFileManager defaultManager];
    NSDictionary *fileInfo =[filemaneger attributesOfItemAtPath:path error:nil];
    fileSize+=fileInfo.fileSize;
    return fileSize/1024.0/1024.0;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  [[_dataArr objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId =@"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        // cell.backgroundColor=[UIColor lightGrayColor];
    }
    cell.backgroundColor=[UIColor lightGrayColor];
    cell.textLabel.text=_dataArr[indexPath.section][indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

-(void)changMembername:(NSNotification *)nf {
    button1.hidden=NO;
    
}

-(void)quitLoginClick:(UIButton*)button {
//    
//    [[NSUserDefaults  standardUserDefaults] removeObjectForKey:@"token"];
//    [[NSUserDefaults  standardUserDefaults] removeObjectForKey:@"membername"];
//    [[NSUserDefaults  standardUserDefaults] removeObjectForKey:@"fansNumber"];
//    [[NSUserDefaults  standardUserDefaults] removeObjectForKey:@"image"];
//    [[NSUserDefaults  standardUserDefaults] removeObjectForKey:@"token"];
//    [[NSUserDefaults  standardUserDefaults] synchronize];
    
    
    button1.hidden=YES;
    view.alpha=1;
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter] ;
    [center postNotificationName:@"quit" object:self userInfo:nil];
    [UIView  animateWithDuration:3 animations:^{
        view.alpha=0;
    }];
}




#pragma mark- popView
-(void)customPopView
{
    CustomPopNavigation *popNavigation = [[CustomPopNavigation alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, NavHeight) title:@"系统设置"];
    __weak AccountSettingViewController* weakSelf=self;
    popNavigation.backPop=^(){
        
        [SVProgressHUD dismiss];
        if (IOS7) {
          [weakSelf   dismissViewControllerAnimated:YES completion:nil];
            [UIView animateWithDuration:0.45
                             animations:^{
                                 [app.drawerController setMaximumRightDrawerWidth:270];
                             }completion:^(BOOL finished)
             {
                 //显示阴影效果
                 app.drawerController.showsShadow = NO;
             }];
        }
        else
        {
            
            [app.drawerController setMaximumRightDrawerWidth:270];
            app.drawerController.showsShadow = NO;
            [weakSelf   dismissViewControllerAnimated:YES completion:nil];
        }
    };
    [self.view addSubview:popNavigation];
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
