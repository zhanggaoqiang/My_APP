//
//  LeftViewController.m
//  choutixiaoguo
//
//  Created by jxmm on 16/1/13.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "LeftViewController.h"
#import "CenterViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "Masonry.h"

@interface LeftViewController ()
{
    CGFloat upViewHeight;
    CGFloat middleheight;
    int widthCount;
    int heightCount;
    
}
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIScrollView *scrollView1;

@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
     self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage  imageNamed:@"左侧抽屉图片.jpg"]];
        
       // self.view.backgroundColor=[UIColor  colorWithRed:128/255 green:152/255 blue:109/255 alpha:1];
        
        
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"item_unclick" object:@[@"0"]];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"item_unclick" object:@[@"1"]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
 _btnArray=[[NSMutableArray alloc] initWithCapacity:0];
    _optionArray=[[NSMutableArray alloc] initWithCapacity:0];
    
    
  // [self creatScrollView];
    [self mainView];
  
    [self microFilmOptionView];
    [self screeningOfNetworkDrama];
    [self findScript];
    
    
}

-(void)mainView
{
   widthCount =self.view.frame.size.width*2/3;
    heightCount=self.view.frame.size.height;
    
    
    UIView *upView=[UIView new];
   // upView.backgroundColor=[UIColor  lightGrayColor];
    [self.view addSubview:upView];
    
    [upView   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(widthCount);
        make.height.mas_equalTo(self.view.frame.size.height/3);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        
        upViewHeight=heightCount/3;
      
        
    }];
    
    
 //中间视图
    UIView *middleVIew=[UIView new];
//   middleVIew.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:middleVIew];
    [middleVIew   mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(upView.mas_bottom).offset(0);
        make.width.mas_equalTo(widthCount);
        make.height.mas_equalTo(heightCount/6);
        middleheight=middleVIew.frame.size.height;
     
        
    }];
//    
    UILabel *channalLabel=[UILabel new];
  
    channalLabel.text=@"频道";
    //channalLabel.backgroundColor=[UIColor blackColor];
    channalLabel.textColor=[UIColor blackColor];
    channalLabel.textAlignment=NSTextAlignmentCenter;
    [middleVIew addSubview:channalLabel];
    
    
    UIView *leftLine=[UIView new];
   leftLine.backgroundColor=[UIColor whiteColor];
    [middleVIew addSubview:leftLine];
    
    UIView *rightView=[UIView new];
    rightView.backgroundColor=[UIColor whiteColor];
    [middleVIew  addSubview:rightView];
    
    
    [rightView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(upView.mas_bottom).offset(heightCount/12);
        make.width.mas_equalTo(widthCount/3);
        make.left.mas_equalTo(widthCount*2/3);
        make.height.mas_equalTo(1);
        
    }];
     [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(upView.mas_bottom).offset(heightCount/12);
        make.width.mas_equalTo(widthCount/3);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(1);
        
    }];
    
    [channalLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(upView.mas_bottom).offset(0);
        make.width.mas_equalTo(widthCount/3);
        make.left.mas_equalTo(widthCount/3);
        make.height.mas_equalTo(self.view.frame.size.height/6);
        
    }];
    
    _scrollView1 =[UIScrollView new];
  
    [self.view addSubview:_scrollView1];
    _scrollView1.userInteractionEnabled=YES;
      [_scrollView1  mas_makeConstraints:^(MASConstraintMaker *make) {
          
          make.top.mas_equalTo(middleVIew.mas_bottom).offset(0);
          make.width.mas_equalTo(widthCount);
          
          make.height.mas_equalTo(heightCount/2);
      }];
    
      for (int i=0; i<3; i++) {
          
        UIButton* button=[UIButton new];
        [upView addSubview:button];
           button.selected=NO;
         [button setTitle:@[@"微电影",@"系列剧",@"找剧本"][i] forState:UIControlStateNormal];
          
          [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [button  setTitleColor:[UIColor  orangeColor ] forState:UIControlStateSelected];
          
          [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
          
        [button   mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.left.mas_equalTo(upView.mas_left).offset((i%3)*widthCount/3);
            make.width.mas_equalTo(widthCount/3);
            make.top.mas_equalTo(upView.mas_top).offset(upViewHeight*(i/3+2)/3);
        }];
          
          UIButton *buttonImage=[UIButton new];
          [buttonImage   setImage:[UIImage   imageNamed:@[@"微电影",@"微视频",@"系列剧"][i]] forState:UIControlStateNormal] ;
          [button  addSubview:buttonImage];
          [buttonImage  mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.mas_equalTo(upView.mas_left).offset((i%3)*widthCount/3+20);
              make.width.mas_equalTo(widthCount/5);
              make.top.mas_equalTo(upView.mas_top).offset(upViewHeight*(i/3+2)/3-widthCount/4);
          }];
          
          button.tag=i;
          
          [_btnArray addObject:button];
          
          if (i==0) {
              _currentBtn=button;
              button.selected=YES;
          }
     }
}

- (void)clickBtn:(UIButton*)sender {
    NSLog(@"执行了吗");
  
    for (UIButton *button in _btnArray) {
        if (sender!=button) {
            button.selected=NO;
        }
        
    }
    sender.selected=YES;
    
    _currentBtn=sender;
    
    switch (sender.tag) {
        case 0:
            _scrollView1.contentOffset=CGPointMake(0, 0);
     
            break;
            case 1:
            _scrollView1.contentOffset=CGPointMake(widthCount, 0);
            break;
             case 2:
          _scrollView1.contentOffset=CGPointMake(widthCount*2, 0);
            break;
        default:
            break;
    }
}

//微电影筛选

-(void)microFilmOptionView {
    NSArray *arr=@[@"全部",@"爱情",@"校园",@"温情",@"搞笑",@"悬疑",@"励志",@"职场",@"社会",@"刑侦",@"战争",@"古装",@"科幻",@"动作",@"穿越",@"广告",@"公益",@"恐怖",@"文艺",@"记录",@"动画",@"剧情",@"其他"];
    for(int i=0;i<arr.count;i++)
    {
        UIButton *button=[UIButton new];
        button.tag=i+100;
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        [button  setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button  setTitleColor:[UIColor  orangeColor ] forState:UIControlStateSelected];
        [_scrollView1  addSubview:button];
        [button addTarget:self action:@selector(clickBtn1:) forControlEvents:UIControlEventTouchUpInside];
        [button  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_scrollView1.mas_left).offset((i%3)*widthCount/3);
            make.width.mas_equalTo(widthCount/3);
            make.top.mas_equalTo(_scrollView1.mas_top).offset(heightCount/6*(i/3)/3);
            
        }];
        
        [_optionArray addObject:button];
        
        if (button.tag==100) {
            
            _currentOptionBtn=button;
            button.selected=YES;
        }
    }
}
//系列剧筛选
-(void)screeningOfNetworkDrama {
    NSArray *arr=@[@"全部",@"都市爱情",@"青春励志",@"创意搞笑",@"恐怖悬疑",@"动画儿童",@"社会纪实"];
    
    for(int i=0;i<arr.count;i++)
    {
        UIButton *button=[UIButton new];
        button.tag=i+200;
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        [button  setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button  setTitleColor:[UIColor  orangeColor ] forState:UIControlStateSelected];
        
        [_scrollView1  addSubview:button];
        [button addTarget:self action:@selector(clickBtn1:) forControlEvents:UIControlEventTouchUpInside];
        [button  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_scrollView1.mas_left).offset(widthCount+(i%3)*widthCount/3);
            make.width.mas_equalTo(widthCount/3);
            make.top.mas_equalTo(_scrollView1.mas_top).offset(heightCount/6*(i/3)/3);
            
        }];

        [_optionArray addObject:button];
    }
}
//找剧本
-(void)findScript {
    NSArray *arr=@[@"全部",@"爱情",@"校园",@"温情",@"搞笑",@"悬疑",@"励志",@"职场",@"社会",@"刑侦",@"战争",@"古装",@"科幻",@"动作",@"穿越",@"广告",@"公益",@"其他"];
    for(int i=0;i<arr.count;i++)
    {
        UIButton *button=[UIButton new];
        button.tag=i+300;
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        [button  setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button  setTitleColor:[UIColor  orangeColor ] forState:UIControlStateSelected];
        [_scrollView1  addSubview:button];
        [button addTarget:self action:@selector(clickBtn1:) forControlEvents:UIControlEventTouchUpInside];
        [button  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_scrollView1.mas_left).offset(widthCount*2+(i%3)*widthCount/3);
            make.width.mas_equalTo(widthCount/3);
            make.top.mas_equalTo(_scrollView1.mas_top).offset(heightCount/6*(i/3)/3);
            
        }];
        
          [_optionArray addObject:button];
    }
}

-(void)clickBtn1:(UIButton *)sender
{
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    NSDictionary *dict=@{@"tag":[[NSNumber alloc] initWithInt:(int)sender.tag]};
    [center  postNotificationName:@"changeTag" object:self userInfo:dict];
    [[NSUserDefaults  standardUserDefaults]  setObject:[[NSNumber alloc] initWithInt:(int)sender.tag]    forKey:@"movieIndex"];
    NSLog(@"%ld",  [[[NSUserDefaults  standardUserDefaults] objectForKey:@"movieIndex"] integerValue] );
    
    [[NSUserDefaults  standardUserDefaults] synchronize];
   
    int tag=(int)sender.tag/100;
    if ([app.drawerController.centerViewController isKindOfClass:[UINavigationController class]] )
    {
        UINavigationController* nav=(UINavigationController*)app.drawerController.centerViewController;
        for (NSObject* object in nav.viewControllers)
            
        {
             if ([object isKindOfClass:[CenterViewController class]])
            {
                
                for (UIButton *button in _optionArray) {
                    if (sender!=button) {
                        button.selected=NO;
                    }
                 }
                sender.selected=YES;
                _currentOptionBtn=sender;
                CenterViewController* center=(CenterViewController*)object;
                center.index = tag - 1;
             
                [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
            }
        }
    }
}
@end
