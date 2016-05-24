

#import <UIKit/UIKit.h>


@protocol CustomNavigationItemDelegate <NSObject>

-(void)leftDrawerPress;
-(void)rightDrawerPress;
-(void)pushWatchViewController;
-(void)pushFindFilm;
@end

@interface CustomNavigationItem : UIView

@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *watchBtn;
@property (nonatomic,strong) UIButton *personBtn;
@property (nonatomic,strong) UIButton *findBtn;
@property (nonatomic,strong) UILabel  *tilteLabel;
@property(nonatomic,strong)UIButton *optionbtn;
@property(nonatomic,copy) void (^btnClick)(int);
@property(nonatomic,strong) void(^kind)(NSString*);



@property (nonatomic , strong) NSMutableArray *items;



@property (nonatomic,assign) id<CustomNavigationItemDelegate>  navDelegate;

- (id)initWithFrame:(CGRect)frame showPerson:(BOOL)aBool showFind:(BOOL)isFind  title:(NSString *)title  rightButton:(void(^)(int))rightButton   kind:(void(^)(NSString *))kind;



- (void)setTitle:(NSString *)title showPerson:(BOOL)aBool showFind:(BOOL)isFind;

@end

