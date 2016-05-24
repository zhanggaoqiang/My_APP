//
//  CarViewController.m
//  养车坊
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CarViewController.h"
#import "UsuallyUseViewController.h"
#import "SDImageCache.h"
#import "TextViewViewController.h"
#import "FreeResiViewController.h"
#import "UMSocial.h"
#define kScreenSize [UIScreen mainScreen].bounds.size
@interface CarViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UMSocialUIDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
}
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation CarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    [self dataInit];
    [self creatTableView];
    UIImageView  *imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon.png"]];
    //imageView.frame=CGRectMake(kScreenSize.width/2-50, 80, 100, 100);
    //[self.view addSubview:imageView];
    self.tableView.tableHeaderView=imageView;
    
}

-(void)dataInit {
    
    _dataArr =[[NSMutableArray alloc] init];
    NSArray *arr= [NSMutableArray arrayWithObjects: @[@"我的分享"],@[@"清除缓存",@"当前版本V1.0"],@[@"关于我们",@"免责声明"],nil];
    [_dataArr addObjectsFromArray:arr];
    [self.tableView reloadData];
    
}

-(void)creatTableView {
    //self.automaticallyAdjustsScrollViewInsets=NO;
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenSize.width, kScreenSize.height-44) style:UITableViewStylePlain];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"35_4.jpg"]];
    
   
    [self.view addSubview:self.tableView];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row=indexPath.row;
    switch (indexPath.section) {
       
        case 0:
            [self myshare:row];
            break;
        case 1:
            [self sectionAction:row];
            break;
            case 2:
            [self nextView:row];
            
        default:
            break;
   
    
    }
}


-(void)myshare:(NSInteger)row {
    
    if (row==0) {
        [self sharedata];
    }
    
}



-(void)sharedata {
    
    NSString * body  =[NSString stringWithFormat:@"这里有惊喜%@",@"http://www.apple.com/cn//?afid=p238|1IkePb9BS-dc_mtid_18707vxu38484_pcrid_7528694320_&cid=aos-cn-kwb-brand"];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"507fcab25270157b37000010" shareText:body shareImage:[UIImage imageNamed:@"icon"]shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatTimeline,UMShareToSms,UMShareToEmail] delegate:self];
}



-(void)nextView:(NSInteger)row {
    if (row==0) {
      
    TextViewViewController *textView =[[TextViewViewController alloc] init];
    [self.navigationController pushViewController:textView animated:YES];
    
    
    }
    if (row==1) {
        FreeResiViewController *frv=[[FreeResiViewController alloc] init];
        [self.navigationController pushViewController:frv animated:YES];
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
    cell.textLabel.text=_dataArr[indexPath.section][indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
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
