//
//  DetailVideoViewController.m
//  choutixiaoguo
//
//  Created by jxmm on 16/3/16.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "DetailVideoViewController.h"
#import "MediaPlayer/MediaPlayer.h"
#import "AFNetworking.h"
#import "MoviePlayer.h"
#import "CommentModel.h"
#import "CommentCell.h"
#import "ZGQHelp.h"
#import "HcCustomKeyboard.h"

@interface DetailVideoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *videoDetailView;
    NSMutableArray *membernameArr;
    AFHTTPRequestOperationManager *_manager;
    NSMutableArray *_dataArr;
    NSString *_playUrl;
    NSString *_introduction;
    NSString *_title;
    NSString *_actor;
    NSString *_autoID;
    MoviePlayer *_view;//微电影播放视图
    MPMoviePlayerController *_moviePlayer;//视频播放控件
    NSMutableArray *_buttonArray;//把按钮放在数组里面
    UIView *_indicatorView;//指示视图
    UIScrollView *_scrollView;//创建选择的scroll
    UILabel *_videoTitleLable;//电影标题
    UILabel *_actorLabel;//主要演员标签
    UILabel *_videoDescriptionLabel;//电影详情描述
    UILabel *_autorIdLabel;//电影上传作者Id
    UITableView *_commentView;//评论
    NSMutableArray *_commentArr;//评论数组
    UITableView *_tableView;//评论列表
    
}

@property(nonatomic,strong)UIView *writeCommentView;
@end

@implementation DetailVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=GRAY_BACK;
   // [self creatBackButton];
    [self creatVideoView];
    
    [self creatVideoDetailAndRidicule];
}



-(void)creatBackButton {
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(0, 25, kScreenSize.width-100, 40)];
    
    [self.view  addSubview:button];
    
    UIButton *button1=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [button1  setImage:[UIImage   imageNamed:@"返回"] forState:UIControlStateNormal];
    [button1  setImage:[UIImage  imageNamed:@"返回High"] forState:UIControlStateSelected];
    [button addSubview:button1];
    
    [button1 addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(40, 0 ,kScreenSize.width-140, 40)];
    _titleLabel.text=@"少年维持着烦恼";
    NSLog(@"%@",_titleLabel.font);
    _titleLabel.font=[UIFont  systemFontOfSize:19];
   
    _titleLabel.textColor=[UIColor  orangeColor];
    [button addSubview:_titleLabel];
    
    UIButton *attentionButton=[[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width-100, 30, 30, 30)];
    [attentionButton  setImage:[UIImage  imageNamed:@"我的关注"] forState:UIControlStateNormal];
    [self.view  addSubview:attentionButton];
    
    UIButton *shareButton=[[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width-50, 30, 40, 40)];
    [shareButton  setImage:[UIImage   imageNamed:@"分享"] forState:UIControlStateNormal];
    [self.view addSubview:shareButton];
}

-(void)backBtn:(UIButton *)sender {
    [self  dismissViewControllerAnimated:YES completion:nil];
}

-(void)creatVideoView {
        membernameArr=[[NSMutableArray alloc] init];
        _manager=[AFHTTPRequestOperationManager manager];
        _manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        _dataArr=[[NSMutableArray alloc] init];
        _manager.requestSerializer.timeoutInterval=10;
        NSString *str=[NSString stringWithFormat:@"http://api2.jxvdy.com/video_info?id=%@", self.movieID];
        [[NSUserDefaults   standardUserDefaults] setObject:self.movieID forKey:@"movieId"];
        NSString *url=[str  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [_manager  GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
            NSLog(@"电影详情是:%@",dict);
            if ([dict[@"playurl"] count]==0)  {
                
                _playUrl=@"";
                
            }
            else {
                    _playUrl=dict[@"playurl"][@"360P"];
            }
            _title=dict[@"title"];
            _actor=dict[@"actors"];
            _introduction=dict[@"introduction"];
            _autoID=[dict[@"pubid"] stringValue];
            
            [self creatScroller];
         
            
            _view =[[MoviePlayer alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.width*9/16) URL:[NSURL   URLWithString:_playUrl] returnBtn:^(int tag, BOOL  isReturn) {
                
                
            } fullScreen:^(BOOL isScreen){
                
                
                                    if (isScreen) {
                                        
                                       
                                        
                                        NSLog(@"进入全屏模式");
                                         [self fullScreen];                                        [UIView  animateWithDuration:.8 animations:^{
                                           
                                            _view.frame = CGRectMake(0, 0, kScreenSize.width, kScreenSize.height);
                                        }completion:nil];
                  
                                    }
                                    if (!isScreen) {
                                        NSLog(@"进入小屏幕模式");
                                        [self notFullScreen];
                                        [UIView  animateWithDuration:.8 animations:^{
                                            
                                            
                                            _view.frame=CGRectMake(0, 0, kScreenSize.width, kScreenSize.width*9/16);

                                            
                                        }completion:nil];
                                        
                                        
                                    }
                
            }];
            
            
            
         //   MoviePlayer *play=[[MoviePlayer alloc] init];
            
            
            
//            if (play.isScreen) {
//                
//                
//                _view=[[MoviePlayer alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.height, kScreenSize.width) URL:[NSURL  URLWithString:_playUrl] returnBtn:^(int tag,BOOL isReturn){
//    
//                    if(tag==100&&isReturn==NO)
//                    {
//                        MoviePlayer *diy=[[MoviePlayer alloc] init];
//                        diy.isScreen=NO;
//                      _moviePlayer.view.frame = CGRectMake(0, 0, kScreenSize.height, kScreenSize.width);
//                        
//                        [self notFullScreen];
//                     }
//                    
//                  }
//                        fullScreen:^(){
//                            
//                         //   [self  notFullScreen];
//                                                  
//                                                  
//            }];
//        }
//            
//            else {
//                _view=[[MoviePlayer alloc] initWithFrame:CGRectMake(0, 20, kScreenSize.width, kScreenSize.width*9/16) URL:[NSURL  URLWithString:_playUrl] returnBtn:^(int tag,BOOL isReturn){
//                    
//                    if (tag==100&&isReturn==YES) {
//                        [_view  removeFromSuperview];
//                        [self dismissViewControllerAnimated:NO completion:nil];
//                    }
//                   if(tag==100&&isReturn==NO)
//                    {
//                    
//                        _moviePlayer.view.frame = CGRectMake(0, 0, kScreenSize.height, kScreenSize.width);
//
//                        MoviePlayer *diy=[[MoviePlayer alloc] init];
//                        diy.isScreen=NO;
//                        
//                        [self notFullScreen];
//                    }
//                    
//                    if(tag==111){
//                        
//                         MoviePlayer *diy=[[MoviePlayer alloc] init];
//                        
//                        if (diy.isScreen) {
//                            _view.frame=self.view.bounds;
//                        
//                            [self  fullScreen];
//                        }
//                        
//                        
//                        
//                    }
//                    
//                } fullScreen:^() {
//                    MoviePlayer *diy=[[MoviePlayer alloc] init];
//                    if (diy.isScreen==NO) {
//                         [self fullScreen];
//                     
//                        _view.frame = CGRectMake(0, 0, kScreenSize.width, kScreenSize.height);
//                   
//
//                    }
//                    if (diy.isScreen==YES) {
//                        
//                    }
//                    
//                    
//                    
//                  
//                    
//                    
//                }];
//            }
            [self.view addSubview:_view];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
}
//强制全屏时调用
-(void)fullScreen
{
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}


//强制退出全屏时调用
-(void)notFullScreen {
    
   
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

#pragma mark - 视频详情和评论
//创建我要吐槽和视频详情按钮
-(void)creatVideoDetailAndRidicule{
    _buttonArray =[[NSMutableArray alloc] init];
    UIButton *videoDetailButton=[UIButton  new];
    videoDetailButton.backgroundColor=[UIColor lightGrayColor];
    [videoDetailButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [videoDetailButton  setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [videoDetailButton  setTitle:@"视频详情" forState:UIControlStateNormal];
    videoDetailButton.titleLabel.textAlignment=NSTextAlignmentCenter;
    videoDetailButton.titleLabel.font=[UIFont  systemFontOfSize:15];
    videoDetailButton.selected=YES;
    videoDetailButton.tag=101;
    [videoDetailButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:videoDetailButton];
    [_buttonArray addObject:videoDetailButton];
    
    UIButton *ridiculeButton=[UIButton new];
    ridiculeButton.backgroundColor=[UIColor lightGrayColor];
    [ridiculeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ridiculeButton  setTitleColor:[UIColor  orangeColor] forState:UIControlStateSelected];
    [ridiculeButton  setTitle:@"我要吐槽" forState:UIControlStateNormal];
    ridiculeButton.titleLabel.textAlignment=NSTextAlignmentCenter;
    ridiculeButton.titleLabel.font=[UIFont  systemFontOfSize:15];
    ridiculeButton.tag=102;
    [ridiculeButton  addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ridiculeButton];
    [_buttonArray addObject:ridiculeButton];
    
    _indicatorView=[UIView new];
    _indicatorView.backgroundColor=[UIColor blackColor];
    _indicatorView.frame=CGRectMake(0, kScreenSize.height/3+50, kScreenSize.width/2, 2);
    
    [self.view addSubview:_indicatorView];
    
    [videoDetailButton   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.width.mas_equalTo(kScreenSize.width/2);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenSize.height/3+20);
        make.height.mas_equalTo(30);
     }];
    
    [ridiculeButton   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(kScreenSize.width/2);
        make.width.mas_equalTo(kScreenSize.width/2);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenSize.height/3+20);
        make.height.mas_equalTo(30);
    }];
}

-(void)btnClick:(UIButton *)sender {
    for (UIButton *button in _buttonArray) {
        if (sender!=button) {
            button.selected=NO;
        }
        
    }
    sender.selected=YES;
    
    switch (sender.tag) {
        case 101:{
             _indicatorView.frame=CGRectMake(0, kScreenSize.height/3+50, kScreenSize.width/2, 2);
            _scrollView.contentOffset=CGPointMake(0, kScreenSize.height*2/3-51);
        }
            break;
            
        case 102:{
             _indicatorView.frame=CGRectMake(kScreenSize.width/2, kScreenSize.height/3+50, kScreenSize.width/2, 2);
            _scrollView.contentOffset=CGPointMake(kScreenSize.width, kScreenSize.height*2/3-51);
        }
            break;
        default:
            break;
    }
}

//创建UIScrollView
-(void)creatScroller {
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, kScreenSize.height/3+51, kScreenSize.width, kScreenSize.height-kScreenSize.height/3-51)];
    _scrollView.backgroundColor=[UIColor   whiteColor];
    
    _scrollView.pagingEnabled=YES;
    _scrollView.contentSize=CGSizeMake(2*kScreenSize.width, kScreenSize.height*2/3-51);
    _scrollView.bounces=NO;
    _scrollView.directionalLockEnabled=YES;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    
    [self.view  addSubview:_scrollView];
    
    _videoTitleLable=[UILabel new];
    _videoTitleLable.text=_title;
    _videoTitleLable.textColor=[UIColor blackColor];
    [_scrollView addSubview:_videoTitleLable];
    
    _actorLabel=[UILabel new];
    _actorLabel.text=_actor;
    _actorLabel.textColor=[UIColor blackColor];
    _actorLabel.font=[UIFont systemFontOfSize:15];
    [_scrollView addSubview:_actorLabel];
    
    
    _videoDescriptionLabel=[UILabel new];
    _videoDescriptionLabel.text=_introduction;
    _videoDescriptionLabel.textColor=[UIColor blackColor];
    _videoDescriptionLabel.font=[UIFont  systemFontOfSize:14];
    [_scrollView   addSubview:_videoDescriptionLabel];
    
        _videoDescriptionLabel.numberOfLines=0;
    NSDictionary *dict=@{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect rect = [_videoDescriptionLabel.text boundingRectWithSize:CGSizeMake(375, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil];
        
      [_videoDescriptionLabel   mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(_scrollView.mas_left).offset(5);
        make.width.mas_equalTo(kScreenSize.width);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenSize.height/3+105);
        make.height.mas_equalTo(rect.size.height);
        
    }];
    
    [_actorLabel   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left).offset(5);
        make.width.mas_equalTo(kScreenSize.width*2/3);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenSize.height/3+75);
        make.height.mas_equalTo(20);
}];
    
    [_videoTitleLable  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left).offset(5);
        make.width.mas_equalTo(kScreenSize.width*2/3);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenSize.height/3+55);
        make.height.mas_equalTo(20);
    }];
    
    NSString *str=[NSString  stringWithFormat:@"http://api2.jxvdy.com/member_info?id=%ld&private=1",[_autoID integerValue]];
    NSLog(@"%@",str);
    [_manager GET: str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dict:%@",dict);
        UIImageView*imageView=[[UIImageView alloc] init];
         [imageView  sd_setImageWithURL:dict[@"face"] placeholderImage:[UIImage imageNamed:@"用户名"]];
             [_scrollView  addSubview:imageView];
        
        UILabel *pubNameLabel=[UILabel new];
        pubNameLabel.text=dict[@"nick"];
        pubNameLabel.textColor=[UIColor blackColor];
        [_scrollView  addSubview:pubNameLabel];
        
        UILabel *profileLabel=[UILabel new];
        profileLabel.text=dict[@"profile"];
        profileLabel.textColor=[UIColor blackColor];
        profileLabel.font=[UIFont  systemFontOfSize:12];
        [_scrollView  addSubview:profileLabel];
        
        UIButton *attentionButton=[UIButton new];
        attentionButton.backgroundColor=[UIColor blackColor];
        [attentionButton  setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [attentionButton  setTitle:@"+关注" forState:UIControlStateNormal];
        attentionButton.titleLabel.font=[UIFont  systemFontOfSize:12];
        attentionButton.layer.masksToBounds=YES;
        attentionButton.layer.cornerRadius=10;
        [_scrollView  addSubview:attentionButton];
        
        [attentionButton   mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(_scrollView.mas_left).offset(kScreenSize.width-10);
            make.width.mas_equalTo(50);
            make.top.mas_equalTo(imageView.mas_top).offset(10);
            make.height.mas_equalTo(20);
            
        }];
        
        [profileLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_scrollView.mas_left).offset(5+kScreenSize.width/8);
            make.width.mas_equalTo(kScreenSize.width/2);
            make.top.mas_equalTo(imageView.mas_top).offset(20);
            make.height.mas_equalTo(20);
            
        }];
        
        [pubNameLabel   mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_scrollView.mas_left).offset(5+kScreenSize.width/8);
            make.width.mas_equalTo(kScreenSize.width/2);
            make.top.mas_equalTo(imageView.mas_top).offset(0);
            make.height.mas_equalTo(kScreenSize.width/16);
        }];
        
        [imageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(_scrollView.mas_left).offset(5);
            make.width.mas_equalTo(kScreenSize.width/8);
            make.top.mas_equalTo(self.view.mas_top).offset(kScreenSize.height/3+130+rect.size.height);
            make.height.mas_equalTo(kScreenSize.width/8);
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"qing请求失败");
        
    }];
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    _tableView.backgroundColor=[UIColor  whiteColor];
    
    
    [_scrollView   addSubview:_tableView];
    
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left).offset(kScreenSize.width);
        make.width.mas_equalTo(kScreenSize.width);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenSize.height/3+51);
        make.height.mas_equalTo(kScreenSize.height*2/3-51-50);
        
    }];
    
    
    
    //写评论
          self.writeCommentView=[[UIView alloc] initWithFrame:CGRectMake(kScreenSize.width, kScreenSize.height-50, kScreenSize.width, 50)];
        self.writeCommentView.backgroundColor=[UIColor lightGrayColor];
        [_scrollView addSubview:self.writeCommentView];
        
        
        [[HcCustomKeyboard customKeyboard]textViewShowView:self customKeyboardDelegate:self];
        self.view.backgroundColor =[UIColor groupTableViewBackgroundColor];
    
    _commentArr=[[NSMutableArray alloc] init];
    
    NSString *str2=[NSString  stringWithFormat:@"http://api2.jxvdy.com/comment_list?id=%@&type=2",self.movieID];
    [_manager GET:str2 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"self.movieId=%@",self.movieID);
        
        NSLog(@"dict是:%@",dict);
        
        if([dict[@"count"] isEqual:@(0)])
        {
            NSLog(@"字典为空");
            [self commentIsNull];
        }
        else {
            
            NSArray *arr=dict[@"list"];
            for (NSDictionary *dict2   in arr) {
                CommentModel *model=[[CommentModel alloc] init];
                model.coid=dict2[@"coid"];
                model.content=dict2[@"content"];
                model.id=dict2[@"id"];
                model.nick=dict2[@"nick"];
                model.like=dict2[@"like"];
                
                if (dict2[@"face"] ==[NSNull  null]) {
                    model.face=nil;
                }
                else {
                    model.face=dict2[@"face"];
                
                }
                
                NSLog(@"model是多少:%@",model);
                NSString *timestring=[dict2[@"time"]   stringValue];
                double t=[timestring  integerValue];
                NSDate *date=[NSDate dateWithTimeIntervalSince1970:t];
                NSDateFormatter *df=[[NSDateFormatter alloc] init];
                df.dateFormat=@"yyyy-MM-dd HH:mm:ss";
                NSString *timeStr=[df stringFromDate:date];
                model.time=timeStr;
                
                [_commentArr addObject:model];
            }
          [_tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
        
    }];
    
 }


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentModel *model=_commentArr[indexPath.row];
    CGFloat height=60;
    height+=[ZGQHelp  textHeightFromTextString:model.content  width:kScreenSize.width-20 fontSize:14];
    
    return height+5;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"-dataArr.count=%ld",_commentArr.count);
    return _commentArr.count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CommentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell=[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    CommentModel *model= _commentArr[indexPath.row];
    
    [cell showData:model];
    
    return cell;
}



-(void)commentIsNull {
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(kScreenSize.width/2-100, 10,200,20)];
    label.text=@"亲，还没有人评论~~!";
    label.textColor=[UIColor blackColor];
    label.font=[UIFont systemFontOfSize:12];
    _tableView.scrollEnabled=NO;
    
    
    
    [_tableView  addSubview:label];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
