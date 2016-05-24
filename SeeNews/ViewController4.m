//
//  ViewController4.m
//  SeeNews
//
//  Created by qianfeng on 15/8/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController4.h"
#import "GameModel.h"

@interface ViewController4 ()

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataPage:(NSInteger)page {
    NSString *newUrl =[NSString stringWithFormat:pleaasntURL ,self.currentPage];
    
    typeof(self) mySelf =self;
    
    
    
    [_manager GET:newUrl parameters:nil success:^(AFHTTPRequestOperation *operation,
                                                  id responseObject){
        
        
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *itemArr=dict[@"data"];
        
        for (NSDictionary *itemDict in itemArr) {
            GameModel *model =[[GameModel alloc] init];
            [model setValuesForKeysWithDictionary:itemDict];
            
            [mySelf.dataArr addObject:model];
            
            
        }
        [mySelf.tableView reloadData];
        [self endRefreshing];
    }
     
     
     
     
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"下载失败");
              
              
          }];
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
