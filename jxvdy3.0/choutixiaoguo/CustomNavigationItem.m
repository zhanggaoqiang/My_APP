

#import "CustomNavigationItem.h"
#import "Masonry.h"
#import "YCXMenu.h"
#import "MicroVideoController.h"


@implementation CustomNavigationItem
@synthesize items = _items;

- (id)initWithFrame:(CGRect)frame showPerson:(BOOL)aBool  showFind:(BOOL)isFind  title:(NSString *)title  rightButton:(void (^)(int))rightButton kind:(void (^)(NSString *))kind
{
    self = [super initWithFrame:frame];
    if (self) {
         _kind=kind;
        _btnClick=rightButton;
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:frame];
  
        bgImageView.userInteractionEnabled=YES;
        [self addSubview:bgImageView];
        
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       [_leftBtn setImage:[UIImage imageNamed:@"菜单"] forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:@"菜单High"] forState:UIControlStateHighlighted];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBtn];
        
        
        self.findBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_findBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
        [_findBtn setImage:[UIImage imageNamed:@"搜索High"] forState:UIControlStateHighlighted];
        [_findBtn addTarget:self action:@selector(pushFindFilm) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_findBtn];

        self.personBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_personBtn setImage:[UIImage imageNamed:@"个人中心-白色"] forState:UIControlStateNormal];
        [_personBtn setImage:[UIImage imageNamed:@"个人中心-白色High"] forState:UIControlStateHighlighted];
        [_personBtn addTarget:self action:@selector(personBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.personBtn.tag=100;
        [self addSubview:_personBtn];
        
        
        self.optionbtn  =[UIButton  buttonWithType:UIButtonTypeCustom];
        
        [_optionbtn   setImage:[UIImage   imageNamed:@"筛选"] forState:UIControlStateNormal];
        [_optionbtn  addTarget:self action:@selector(optionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_optionbtn];
        

        
        
        self.tilteLabel=[UILabel new];
        self.tilteLabel.text=title;
        self.tilteLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:self.tilteLabel];
        
        [self.tilteLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(kScreenSize.width/2-50);
            make.top.mas_equalTo(self.mas_top).offset(30);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
            
            
        }];
        
        [self.leftBtn   mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.top.mas_equalTo(self.mas_top).offset(20);
            make.width.mas_equalTo(44);
            make.height.mas_equalTo(44);
            
        }];
        
        
        [self.findBtn   mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(44);
            make.right.mas_equalTo(self.personBtn.mas_left).offset(-0);
            make.top.mas_equalTo(self.mas_top).offset(20);
            
        }];
        
        
        if (aBool == NO) {
            _watchBtn.hidden = YES;
        }
        if (isFind == NO) {
            _findBtn.hidden = YES;
        }
        
         [self.personBtn   mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(20);
            make.right.mas_equalTo(self.mas_right).offset(0);
            make.width.mas_equalTo(44);
            make.height.mas_equalTo(44);
            
        }];
        
        [self.optionbtn   mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(44);
            make.top.mas_equalTo(self.mas_top).offset(20);
            make.right.mas_equalTo(self.findBtn.mas_left).offset(0);
            
            
        }];
        
    }
    return self;
}


-(void)optionBtn:(UIButton *)sender {
    
    // 显示默认样式的Menu
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *btn = sender;
    
        [YCXMenu setTintColor:[UIColor whiteColor]];
        [YCXMenu showMenuInView:self.superview fromRect:btn.frame menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
            NSLog(@"%@",item);
            
            switch (item.tag) {
            
                    
                case 101:{
                    _kind(@"time");
                }
                    break;
                    
                case 102:{
                    _kind(@"hits");
                }
                    break;
                    
                case 103:{
                    _kind(@"like");
                }
                    break;
                    
                    
                    
                default:{
                    _kind(@"time");
                }
                    break;
            }
            
        }];
    }
}


#pragma mark - setter/getter
- (NSMutableArray *)items {
    
  
    
    
    YCXMenuItem *menuTitle2 = [YCXMenuItem menuItem:@"最新发布"
                                              image:nil
                                                tag:101
                                           userInfo:@{@"title":@"Menu"}];
    menuTitle2.foreColor = [UIColor blackColor];
    menuTitle2.titleFont = [UIFont systemFontOfSize:15];
    
    
    YCXMenuItem *menuTitle3 = [YCXMenuItem menuItem:@"观看最多"
                                              image:nil
                                                tag:102
                                           userInfo:@{@"title":@"Menu"}];
    menuTitle3.foreColor = [UIColor blackColor];
    menuTitle3.titleFont = [UIFont systemFontOfSize:15];
    
    YCXMenuItem *menuTitle4 = [YCXMenuItem menuItem:@"喜欢最多"
                                              image:nil
                                                tag:103
                                           userInfo:@{@"title":@"Menu"}];
    menuTitle4.foreColor = [UIColor blackColor];
    menuTitle4.titleFont = [UIFont systemFontOfSize:15];
    

    
    if (!_items) {
        
         _items = [@[
                     menuTitle2,
                     menuTitle3,
                     menuTitle4,
                     
                     ] mutableCopy];
    }
    return _items;
}



- (void)setItems:(NSMutableArray *)items {
    _items = items;
}

-(void)personBtnClick:(UIButton *)sender {
    
    _btnClick((int)sender.tag);
    
}
- (void)setTitle:(NSString *)title showPerson:(BOOL)aBool showFind:(BOOL)isFind
{
    if (aBool == YES)
    {
        _findBtn.frame=CGRectMake(200, self.frame.size.height - 44, 40, 44);
        _watchBtn.hidden = NO;
    }
    else
    {
        _findBtn.frame=CGRectMake(240, self.frame.size.height-44, 40, 44);
        _watchBtn.hidden = YES;
    }
    if (isFind==YES) {
        _findBtn.hidden=NO;
    }else
    {
        _findBtn.hidden=YES;
    }
    [_tilteLabel setText:title];
}

-(void)pushFindFilm
{
    if ([_navDelegate respondsToSelector:@selector(pushFindFilm)])
    {
        [_navDelegate pushFindFilm];
    }
}


- (void)leftBtnClick
{
    if ([_navDelegate respondsToSelector:@selector(leftDrawerPress)])
    {
        [_navDelegate leftDrawerPress];
    }
}





@end
