//
//  MoviePlayer.m
//  MoviePlayer
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import "MoviePlayer.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MyActivityIndicatorView.h"
#import "Slider.h"
@interface MoviePlayer ()<ProgressDelegate>




@end


@implementation MoviePlayer

{
    PanDirection panDirection; // 定义一个实例变量，保存枚举值
    BOOL isVolume; // 判断是否正在滑动音量
    CGFloat sumTime; // 用来保存快进的总时长
    BOOL  isReturn;
 
}


- (instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)url returnBtn:(void(^)(int,BOOL))block fullScreen:(void (^)(BOOL  ))fullblock

{
    self = [super initWithFrame:frame];
    if (self) {
        _returnBtn=block;
        _fullBtn=fullblock;
        isReturn=YES;
        self.isScreen=NO;
        self.isDown=NO;
        self.isAutoTurn=NO;
        self.qiangzhi=NO;
        self.qiangzhi2=NO;
        
        [UIApplication  sharedApplication].statusBarHidden=YES;
        
        
        
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qiangzhi:) name:@"qiangzhi" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qiangzhi2:) name:@"qiangzhi2" object:nil];
        
        
               
        self.moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
        self.moviePlayer.view.frame = self.bounds;
        // 去除系统自带的控件
        self.moviePlayer.controlStyle = MPMovieControlStyleNone;
        // 视屏开始播放的时候，这个view开始响应用户的操作，把它关闭
        self.moviePlayer.view.userInteractionEnabled = NO;
        [self.moviePlayer play];
        [self addSubview:_moviePlayer.view];
        
        
       
        
        // 添加暂停播放按钮
        self.play = [UIButton buttonWithType:UIButtonTypeCustom];
       // self.play.frame = CGRectMake(0, 0, 40, 40);
        //self.play.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self.play setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
        [self.play setImage:[UIImage imageNamed:@"play"] forState:UIControlStateSelected];
        self.play.hidden = YES;
        // 添加暂停播放方法
        [self.play addTarget:self action:@selector(playMovie:) forControlEvents:UIControlEventTouchUpInside];
        [self.play addTarget:self action:@selector(viewNoDismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_play];
        
        
        // 添加底部进度条和时间显示
        // 1.添加底部view
       
        self.sliderView = [[UIView alloc]init];
        self.sliderView.backgroundColor = [UIColor blackColor];
        self.sliderView.hidden = YES;
        [self addSubview:_sliderView];
        // 2.添加开始时间label
        self.begin = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 50, 45)];
        self.begin.textColor = [UIColor whiteColor];
        self.begin.font=[UIFont systemFontOfSize:12];
        self.begin.textAlignment = NSTextAlignmentCenter;
        [_sliderView addSubview:_begin];
        // 3.添加进度条
       
        self.progress = [[Slider alloc]initWithFrame:CGRectMake(55+10, 0, kScreenSize.width-140, 45)];
        [self.progress.slider addTarget:self action:@selector(progressAction:event:) forControlEvents:UIControlEventValueChanged];
        [_sliderView addSubview:_progress];
        // 4.添加总时长label
        self.end = [[UILabel alloc]initWithFrame:CGRectMake(kScreenSize.width-80, 0, 50, 45)];
        self.end.textColor = [UIColor whiteColor];
        self.end.font=[UIFont systemFontOfSize:12];
        self.end.textAlignment = NSTextAlignmentCenter;
        // 5.添加全屏和收缩button
        
        self.screenButton =[[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width-40, 5, 40, 40)];
        [self.screenButton setImage:[UIImage imageNamed:@"全屏"] forState:UIControlStateNormal];
        [self.screenButton setImage:[UIImage imageNamed:@"全屏-触发"] forState:UIControlStateHighlighted];
        [self.screenButton addTarget:self action:@selector(screenBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.screenButton.tag=111;
        [_sliderView addSubview:self.screenButton];
        // 6.添加重新播放按钮
//        _back = [DIYButton buttonWithType:UIButtonTypeCustom];
//        self.back.frame = CGRectMake(15, 15,20, 20);
//        self.back.backgroundColor = [UIColor whiteColor];
//        [self.back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_sliderView addSubview:_back];
//        self.back.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor redColor]);
        
           // 设置代理
        self.progress.delegate = self;
    
        
        
        // 缓冲条背景颜色
        self.progress.cacheColor = [UIColor greenColor];
        [_sliderView addSubview:_end];
        
        
        
        _sliderView.hidden=YES;
               // 接收视屏加载好后的通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(durationAvailable) name:MPMovieDurationAvailableNotification object:nil];
       // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endVideo) name:MPMovieFinishReasonPlaybackEnded object:nil];
        
        
        // 添加菊花动画
        self.activity = [[MyActivityIndicatorView alloc]init];
        [self addSubview:_activity];
        [_activity startAnimating];
        
        // 在滑块上添加时间显示label，拖动滑块的时候显示进度
        self.thumbLabel = [[UILabel alloc]initWithFrame:CGRectMake(-15, -40, 50, 25)];
        self.thumbLabel.layer.masksToBounds = YES; // 显示label的边框，不然没有圆角效果
        self.thumbLabel.layer.cornerRadius = 3; // 显示圆角
        self.thumbLabel.textAlignment = NSTextAlignmentCenter;
        self.thumbLabel.backgroundColor = [UIColor whiteColor];
        [self.progress.thumbView addSubview:_thumbLabel];
        // 一开始让label隐藏
        self.thumbLabel.hidden = YES;
        
//        // 创建自己的音量条
//        self.volume = [[UISlider alloc]init]; // 先让slider横放
//        self.volume.center = CGPointMake(40, frame.size.height / 2);
//        [self.volume setThumbImage:[UIImage imageNamed:@"nil"] forState:UIControlStateNormal]; // 给滑块一个空白的图片
//        // 把slider旋转90度
//        self.volume.transform = CGAffineTransformMakeRotation(M_PI * 1.5); // M_PI_2是90度，M_PI * 1.5是180度
//        [self addSubview:_volume];
//        
//        self.volume.hidden=YES;
//        
//        // 添加并接收系统的音量条
//        // 把系统音量条放在可视范围外，用我们自己的音量条来控制
//        MPVolumeView *volum = [[MPVolumeView alloc]init];
//        // 遍历volumView上控件，取出音量slider
//        for (UIView *view in volum.subviews) {
//            if ([view isKindOfClass:[UISlider class]]) {
//                // 接收系统音量条
//                self.volumeSlider = (UISlider *)view;
//                // 把系统音量的值赋给自定义音量条
//                self.volume.value = self.volumeSlider.value;
//            }
//        }
//        // 添加系统音量控件
//        [self addSubview:volum];
//        
//        // 创建两个UIImageView，用来展示音量的max，min图标
//        CGFloat volumWidth = self.volumeSlider.frame.size.height; // 图标的高度
//        UIImageView *maxImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.volume.frame.size.height-10, 0, volumWidth, volumWidth)];
//        maxImageView.image = [UIImage imageNamed:@"yinliangda"];
//        [self.volume addSubview:maxImageView];
//        UIImageView *minImageView = [[UIImageView alloc]initWithFrame:CGRectMake(- volumWidth+10, 0, volumWidth, volumWidth)];
//        minImageView.image = [UIImage imageNamed:@"yinliangxiao"];
//        [self.volume addSubview:minImageView];
//        
//        // 一开始先隐藏音量条,让其上下滑动的时候出现，手势在加载完成后添加
//        self.volume.hidden = YES;
//
        
        // 水平滑动显示的进度label
        self.horizontalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height / 2, frame.size.width, 40)];
        self.horizontalLabel.textColor = [UIColor yellowColor];
        self.horizontalLabel.textAlignment = NSTextAlignmentCenter;
        self.horizontalLabel.text = @"00:00 / --:--";
        // 一上来先隐藏
        self.horizontalLabel.hidden = YES;
        
        [self addSubview:_horizontalLabel];
 
        
        //顶部视图
       
        self.topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 675, 40)];
        self.topView.backgroundColor=[UIColor blackColor];
        [self addSubview:_topView];
        self.topView.hidden=YES;
        
        //1,清晰度选择
        self.definitionBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
        self.definitionBtn.frame=CGRectMake(600, 5, 40, 30);
        [self.definitionBtn  setTitle:@"标清" forState:UIControlStateNormal];
        [self.definitionBtn  setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
        [self.definitionBtn  addTarget:self action:@selector(defBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.definitionBtn.layer.borderWidth=1;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 1, 1,1, 1 });
        self.definitionBtn.layer.borderColor=borderColorRef ;
        [_topView addSubview:_definitionBtn];
        
       //2.pop返回按钮
        _returnButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
        [_returnButton  setBackgroundImage:[UIImage  imageNamed:@"返回"] forState:UIControlStateNormal];
        [_returnButton  setBackgroundImage:[UIImage  imageNamed:@"返回High"] forState:UIControlStateHighlighted];
        [_topView addSubview:_returnButton];
        _returnButton.tag=100;
        [_returnButton addTarget:self action:@selector(returnBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
    return self;
}



-(void)qiangzhi:(NSNotification *) nf {
    
    self.qiangzhi=YES;
    
}


-(void)qiangzhi2:(NSNotification *) nf {
    
    self.qiangzhi2=YES;
    
    
    
}


-(void)returnBtn:(UIButton *)sender {
    
//    if (self.isScreen==YES) {
//        self.isScreen=NO;
//    }
//    else if(self.isScreen==NO)
//    {
//        isReturn=YES;
//    }
//       
//    _returnBtn((int)sender.tag, isReturn);
}


-(void)screenBtn:(UIButton *)sender {
    
    
    
    self.isScreen=!self.isScreen;
    [self.screenButton setImage:sender.selected?[UIImage imageNamed:@"取消全屏"]:[UIImage imageNamed:@"全屏"] forState:UIControlStateNormal];
    [self.screenButton setImage:sender.selected?[UIImage imageNamed:@"取消全屏-触发"]:[UIImage imageNamed:@"全屏-触发"] forState:UIControlStateHighlighted];
   
     _fullBtn(self.isScreen);
    
    if (self.isScreen) {
        self.moviePlayer.view.frame=CGRectMake(0, 0, kScreenSize.width, kScreenSize.height);
    
    }
    
    
    if (!self.isScreen) {
        self.moviePlayer.view.frame=CGRectMake(0, 0, kScreenSize.width, kScreenSize.width*9/16);

    }
 
    
    

//       if (self.isScreen   ) {
//       [self fullScreen];
//      
//           
//          
//        isReturn=NO;
//    }
//    if (!self.isScreen) {
//      [self notFullScreen];
//        isReturn=YES;
//        
//    }
}

-(void)defBtnClick:(UIButton *)button {
    static  int k;
    k++;
    int  flag=k%2;
  
    if (flag==1) {
        self.selectDefinitionView=[[UIView alloc] init ];
        self.selectDefinitionView.frame=CGRectMake(600, 41, 40,100);
        self.selectDefinitionView.backgroundColor=[UIColor blackColor];
        [self.moviePlayer.view addSubview:self.selectDefinitionView];
        
        for (NSInteger i=0; i<=2; i++) {
            UIButton *button1=[[UIButton alloc] initWithFrame:CGRectMake(0, i*30, 40, 30)];
            [button1   setTitle:@[@"标清",@"高清",@"超清"][i] forState:UIControlStateNormal];
            [button1   setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
            button1.tag=i+201;
            [self.selectDefinitionView addSubview:button1];
            
        }

    }
    
    else {
        self.selectDefinitionView.hidden=YES;
        
    }
}

-(void)layoutSubviews {
    
    
    
    if (self.isScreen) {
        self.sliderView.frame=CGRectMake(0, kScreenSize.height-45, kScreenSize.width, 45);
        self.play.center = CGPointMake(kScreenSize.width/2, kScreenSize.height/2);
        self.volume.center = CGPointMake(40,self.frame.size.height/2);
        self.horizontalLabel.center=CGPointMake( self.frame.size.width/2, self.frame.size.height-90);
        self.volume.hidden=NO;
        
        self.progress.frame=CGRectMake(65, 0,kScreenSize.width-150, 20);
        self.begin.frame=CGRectMake(5, 0, 50, 20);
        
        self.screenButton.frame=CGRectMake(kScreenSize.width-50, 0, 50, 50);
        self.end.frame=CGRectMake(kScreenSize.width-90, 0, 40, 20);
        self.definitionBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, kScreenSize.width-75, 40, 40)];
    }
    
   if   (!self.isScreen) {
       

            self.sliderView.frame=CGRectMake(0, self.frame.size.height-45, kScreenSize.width, 45);
            self.play.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            self.horizontalLabel.center=CGPointMake( self.frame.size.width/2, self.frame.size.height-70);

       self.volume.hidden=YES;
            self.progress.frame=CGRectMake(65, 0,kScreenSize.width-150, 20);
             self.begin.frame=CGRectMake(5, 0, 50, 20);
            
            self.screenButton.frame=CGRectMake(kScreenSize.width-50, 0, 50, 50);
            self.end.frame=CGRectMake(kScreenSize.width-90, 0, 40, 20);
       
       
        }
        
//        if (self.qiangzhi2==YES) {
//        self.sliderView.frame=CGRectMake(0,self.frame.size.height-45,kScreenSize.width, 45);
//        self.end.frame=CGRectMake(kScreenSize.width-80, 0, 50, 45);
//         self.begin.frame=CGRectMake(5, 0, 50, 45);
//        self.progress.frame=CGRectMake(55+10, 0, kScreenSize.width-140, 45);
//         self.play.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
//         self.volume.center=CGPointMake(40, self.frame.size.height/2);
//         self.screenButton.frame=CGRectMake(kScreenSize.width-40, 5, 40, 40);
//            
//            self.horizontalLabel.center=CGPointMake( self.frame.size.width/2, self.frame.size.height-90);
//         self.qiangzhi2=NO;
//         
//        }
//  
//    }
//    
//    if (self.qiangzhi2==YES&&self.isScreen&&!self.isAutoTurn) {
//        self.sliderView.frame=CGRectMake(0,self.frame.size.height-45,kScreenSize.width, 45);
//        self.end.frame=CGRectMake(kScreenSize.width-80, 0, 50, 45);
//        self.begin.frame=CGRectMake(5, 0, 50, 45);
//        self.progress.frame=CGRectMake(55+10, 0, kScreenSize.width-140, 45);
//        self.play.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
//        self.volume.center=CGPointMake(40, self.frame.size.height/2);
//        self.screenButton.frame=CGRectMake(kScreenSize.width-40, 5, 40, 40);
//        
//        self.horizontalLabel.center=CGPointMake( self.frame.size.width/2, self.frame.size.height-90);
   // }
}
#pragma mark - 执行滑块代理方法
- (void)touchView:(float)value
{
    // 跳转到指定位置
    self.moviePlayer.currentPlaybackTime = value;
}

#pragma mark - 拖进度条执行的方法
- (void)progressAction:(UISlider *)progress event:(UIEvent *)event
{
    // 拿到手势
    UITouch *touch = [[event allTouches]anyObject];
    // 保证视图不消失
    [self viewNoDismiss];
    
    switch (touch.phase) {
        case UITouchPhaseBegan:{
//            NSLog(@"开始移动");
            // 开始拖动滑块的时候，让时间label显示
            self.thumbLabel.hidden = NO;
            break;
        }
        case UITouchPhaseMoved:{
//            NSLog(@"正在移动");
            // 移动的时候把value给时间label
            self.thumbLabel.text = [self durationStringWithTime:(int)progress.value];
            break;
        }
        case UITouchPhaseEnded:{
            // 跳转到指定位置
//            NSLog(@"移动结束");
             self.begin.text = [self durationStringWithTime:progress.value];
            self.moviePlayer.currentPlaybackTime = progress.value;
            // 移动结束隐藏时间显示label
            self.thumbLabel.hidden = YES;
            break;
        }
        default:
            break;
    }
}



#pragma mark - 播放状态，timer方法
- (void)playbackStates:(NSTimer *)timer
{
    // 给进度条赋值
    // 当用户互动滑块的时候不去赋值
    // 这里不用 touchInside，因为touchInside有yes和no，松手后滑块有可能不走
    if (!self.progress.slider.highlighted) {
        self.progress.slider.value  = self.moviePlayer.currentPlaybackTime;
        // 没点滑块的时候时间label隐藏
        self.thumbLabel.highlighted = YES;
    }
    
    // 实时播放时间
    self.begin.text = [self durationStringWithTime:(int)self.moviePlayer.currentPlaybackTime];
    self.progress.cache = self.moviePlayer.playableDuration;
}

#pragma mark - 返回按钮执行的方法
- (void)backAction:(UIButton *)button
{
    self.moviePlayer.currentPlaybackTime=0;
}


#pragma mark - 视频加载好之后执行的通知
- (void)durationAvailable
{
    // 隐藏返回按钮
   // self.back.hidden = YES;
    // 取消菊花动画
    [self.activity stopAnimating];
    // 添加一个tap手势,在视频加载好之后添加轻拍
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    
    
    // 给视频总时长赋值
    self.end.text = [self durationStringWithTime:(int)self.moviePlayer.duration];
    // 修改progress的最大值和最小值
    self.progress.slider.maximumValue = self.moviePlayer.duration;
    self.progress.slider.minimumValue = 0;
    
    
    // 加载完后添加timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(playbackStates:) userInfo:nil repeats:YES];
    [self.timer fire];
    
    
    // 添加平移手势，用来控制音量和快进快退
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panDirection:)];
    [self addGestureRecognizer:pan];
    
    
}


#pragma mark - 平移手势方法
- (void)panDirection:(UIPanGestureRecognizer *)pan
{
    // 我们要响应水平移动和垂直移动
    // 根据上次和本次移动的位置，算出一个速率的point
    CGPoint veloctyPoint = [pan velocityInView:self];
    // 判断是垂直移动还是水平移动
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{ // 开始移动
//            NSLog(@"x:%f  y:%f",veloctyPoint.x, veloctyPoint.y);
            // 使用绝对值来判断移动的方向
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            if (x > y) { // 水平移动
                panDirection = PanDirectionHorizontalMoved;
                // 取消隐藏
                self.horizontalLabel.hidden = NO;
                // 给sumTime初值
                sumTime = self.moviePlayer.currentPlaybackTime;
            }
            else if (x < y){ // 垂直移动
                panDirection = PanDirectionVerticalMoved;
                // 显示音量控件
                self.volume.hidden = NO;
                // 开始滑动的时候，状态改为正在控制音量
                isVolume = YES;
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{ // 正在移动
            switch (panDirection) {
                case PanDirectionHorizontalMoved:{
                    [self horizontalMoved:veloctyPoint.x]; // 水平移动的方法只要x方向的值
                    break;
                }
                case PanDirectionVerticalMoved:{
                    [self verticalMoved:veloctyPoint.y]; // 垂直移动方法只要y方向的值
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case UIGestureRecognizerStateEnded:{ // 移动停止
            // 移动结束也需要判断垂直或者平移
            // 比如水平移动结束时，要快进到指定位置，如果这里没有判断，当我们调节音量完之后，会出现屏幕跳动的bug
            switch (panDirection) {
                case PanDirectionHorizontalMoved:{
                    // 隐藏视图
                    self.horizontalLabel.hidden = YES;
                    // 在滑动结束后，视屏要跳转
                    self.moviePlayer.currentPlaybackTime = sumTime;
                    // 把sumTime滞空，不然会越加越多
                    sumTime = 0;
                    break;
                }
                case PanDirectionVerticalMoved:{
                    // 垂直移动结束后，隐藏音量控件
                    self.volume.hidden = YES;
                    // 且，把状态改为不再控制音量
                    isVolume = NO;
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark - pan垂直移动的方法
- (void)verticalMoved:(CGFloat)value
{
    // 更改音量控件value
    self.volume.value -= value / 10000; // 越小幅度越小
    // 更改系统的音量
    self.volumeSlider.value = self.volume.value;
    
}
#pragma mark - pan水平移动的方法
- (void)horizontalMoved:(CGFloat)value
{
    // 快进快退的方法
    NSString *style = @"";
    if (value < 0) {
        style = @"<<";
    }
    else if (value > 0){
        style = @">>";
    }
    
    // 每次滑动需要叠加时间
    sumTime += value / 200;
    
    // 需要限定sumTime的范围
    if (sumTime > self.moviePlayer.duration) {
        sumTime = self.moviePlayer.duration;
    }else if (sumTime < 0){
        sumTime = 0;
    }
    
    // 当前快进的时间
    NSString *nowTime = [self durationStringWithTime:(int)sumTime];
    // 总时间
    NSString *durationTime = [self durationStringWithTime:(int)self.moviePlayer.duration];
    // 给label赋值
    self.horizontalLabel.text = [NSString stringWithFormat:@"%@ %@ / %@",style, nowTime, durationTime];
    
    
}

#pragma mark - 根据时长求出字符串
- (NSString *)durationStringWithTime:(int)time
{
    // 获取分钟
    NSString *min = [NSString stringWithFormat:@"%02d",time / 60];
    // 获取秒数
    NSString *sec = [NSString stringWithFormat:@"%02d",time % 60];
    return [NSString stringWithFormat:@"%@:%@", min, sec];
}




#pragma mark - 播放暂停方法
- (void)playMovie:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        // 暂停
        [self.moviePlayer pause];
    }else{
        // 播放
        [self.moviePlayer play];
    }
    
}

#pragma mark - tap手势方法
- (void)tapAction
{
    [self viewNoDismiss];
    self.play.hidden = !self.play.hidden;
    self.sliderView.hidden = !self.sliderView.hidden;
    
   self.topView.hidden=!self.topView.hidden;

    //self.button1.hidden=!self.button1.hidden;
   // self.selectDefinitionView.hidden=self.topView.hidden;

    ;
    // 音量视图不是和其他视图一起出现的，如果取反，会有交替出现的bug，让它接收前面控件的hidden状态，使之同步
    self.volume.hidden = self.topView.hidden;

}

#pragma mark - 保证视图不消失的方法,每次调用这个方法，把之前的倒计时抹去，添加一个新的3秒倒计时
- (void)viewNoDismiss
{
    // 先取消一个3秒后的方法，保证不管点击多少次，都只有一个方法在3秒后执行
    [UIView cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissAction) object:nil];
    
    // 3秒后执行的方法
        [self performSelector:@selector(dismissAction) withObject:nil afterDelay:3];
   
}

// 3秒后执行的方法
- (void)dismissAction
{
    self.play.hidden = YES;
    self.sliderView.hidden = YES;
    self.back.hidden = YES;
    self.topView.hidden=YES;
   // self.selectDefinitionView.hidden=YES;
    // 如果没有在控制音量，则隐藏
    if (!isVolume) {
         self.volume.hidden = YES;
    }
   
}

// 给视频名称赋值
- (void)setTitle:(NSString *)title
{
    self.back.textLabel.text = title;
}






@end
