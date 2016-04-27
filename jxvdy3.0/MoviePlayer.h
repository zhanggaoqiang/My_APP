//
//  MoviePlayer.h
//  MoviePlayer
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 RockyFung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIYButton.h"
#import "Slider.h"

#import "MyActivityIndicatorView.h"
@class MPMoviePlayerController;

// 枚举值，包含水平移动方向和垂直移动方向
typedef NS_ENUM(NSInteger, PanDirection){
    PanDirectionHorizontalMoved,
    PanDirectionVerticalMoved
};

@interface MoviePlayer : UIView

@property (nonatomic, strong, readonly) DIYButton *back; // 返回按钮

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSTimer *timer; // 定时器
@property(nonatomic,assign)BOOL isScreen;//判断是否是全屏状态


@property(nonatomic,copy)void (^returnBtn)(int,BOOL);
@property(nonatomic,strong)void(^fullBtn)(BOOL);

@property(nonatomic,assign)BOOL isAutoTurn;
//+(MPMoviePlayerController *)sharedMovieplay;

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer; // 视频播放控件


@property (nonatomic, strong) UIButton *play; // 播放按钮

@property (nonatomic, strong) UILabel *begin; // 开始的时间label

@property (nonatomic, strong) UILabel *end; // 结束时间label

@property (nonatomic, strong) UISlider *volume; //声音进度条

@property (nonatomic, strong) UIView *sliderView; // 进度条和时间label底部的view

@property (nonatomic, strong) Slider *progress;

@property (nonatomic, strong) MyActivityIndicatorView *activity; // 添加菊花动画

@property (nonatomic, strong) UILabel *thumbLabel; // 添加到滑块上的时间显示label

@property (nonatomic, strong) UISlider *volumeSlider; // 用来接收系统音量条

@property (nonatomic, strong) UILabel *horizontalLabel; // 水平滑动时显示进度

@property (nonatomic,strong)  UIButton *screenButton;

@property (nonatomic,strong)   UIView  *topView;  //横屏播放时的顶部视图

@property  (nonatomic,strong) UIButton * definitionBtn; //清晰度的选择

@property  (nonatomic,strong) UIView *selectDefinitionView; //清晰度视图

@property(nonatomic,strong)UIButton *button1;

@property (nonatomic)BOOL  isDown;
@property(nonatomic)BOOL  qiangzhi;
@property(nonatomic)BOOL  qiangzhi2;

@property(nonatomic,strong)UIButton *returnButton;//返回按钮

@property(nonatomic,strong)UIButton *fullScreen;//全屏按钮








// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)url  returnBtn:(void(^)(int,BOOL))block  fullScreen:(void(^)(BOOL))fullblock;




//@property(nonatomic,copy)void (^backBlock)(int);

@end
