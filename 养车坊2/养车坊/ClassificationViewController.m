//
//  ClassificationViewController.m
//  养车坊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ClassificationViewController.h"

#import "MaintaincarViewController.h"
#import "DriveSkilViewController.h"
#import "BasicViewController.h"
#import "CarKnologyViewController.h"




#define kScreenSize [UIScreen mainScreen].bounds.size

@interface ClassificationViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSArray *_arr;
}

@end

@implementation ClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    _arr=[[NSArray alloc] init];
    _tableview =[[UITableView alloc] initWithFrame:CGRectMake(kScreenSize.width/4, kScreenSize.height/4, kScreenSize.width/2, kScreenSize.height/2) style:UITableViewStylePlain];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"chebiao.jpg"]];
    _tableview.backgroundColor=[UIColor clearColor];
    
    _arr =@[@"汽车百科",@"保养秘诀",@"驾驶技巧",@"必备车品"];
    self.navigationItem.title=@"分类";
    [self.view addSubview:_tableview];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView   dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        
    }
    cell.textLabel.text=_arr[indexPath.row];
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.textColor=[UIColor redColor];
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.font =[UIFont systemFontOfSize:20];
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: {
            CarKnologyViewController *cals =[[CarKnologyViewController alloc] init];
            
            [self.navigationController pushViewController:cals animated:YES];
        }
            
            break;
        case 1: {
            MaintaincarViewController *mvc=[[MaintaincarViewController alloc] init];
            [self.navigationController pushViewController:mvc animated:YES];
            
        }
            break;
        case 2: {
            DriveSkilViewController *dvc=[[DriveSkilViewController alloc] init];
            [self.navigationController pushViewController:dvc animated:YES];
            
        }
            break;
            
        case 3: {
            BasicViewController *bvc=[[BasicViewController alloc] init];
            [self.navigationController pushViewController:bvc animated:YES];
            
            
        }
            
        break;
            
        default:
            break;
    }
    
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
