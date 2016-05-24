//
//  HomeView5.m
//  SeeNews
//
//  Created by qianfeng on 15/8/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HomeView5.h"
#import "NewsObject.h"
#import "ADView.h"


@implementation HomeView5

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)creatTableView {
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-94) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    [self addSubview:self.tableView];
    
    
    
    
    
}






-(void)loadDataPage:(NSInteger)page {
    
    NSString *newUrl =[NSString stringWithFormat:HeadNews5,self.currentPage];
    
    
    __weak typeof(self) mySelf =self;
    [_manager GET:newUrl parameters:nil success:^(AFHTTPRequestOperation *operation,
                                                  id responseObject){
        
        if (self.currentPage==1) {
            [self.dataArr removeAllObjects];
            
        }
        
        
        if (responseObject) {
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray *itemArr=dict[@"data"][@"itemList"];
            
            for (NSDictionary*itemDict in itemArr) {
                
                
                
                NewsObject *model =[[NewsObject alloc] init];
                
                model.itemTitle=itemDict[@"itemTitle"];
                
                
                model.imgUrl1=itemDict[@"itemImage"][@"imgUrl1"];
                
                
                [mySelf.dataArr addObject:model];
                
                
                
                
                
            }
            
        }
        
        
        
        
        
        
        
        [mySelf.tableView reloadData];
        [self endRefreshing];
        
        
    }
     
     
     
     
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"下载失败");
              
          }];
    
    
}




@end
