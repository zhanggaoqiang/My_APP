//
//  HomeViewController.m
//  SeeNews
//
//  Created by qianfeng on 15/8/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewWillShow.h"
#import "BaseView.h"

@interface HomeViewController ()<UIScrollViewDelegate>
{
   
    UIScrollView *_scroll;
    UIScrollView *_scrollSeg;
    UISegmentedControl *_seg;
}





@end

@implementation HomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self creatScroller];
    [self creatSegView];
}




-(void)creatSegView {
    
    
    _scrollSeg=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenSize.width, 30)];
    
    _scrollSeg.backgroundColor=[UIColor lightGrayColor];
   
    [self.view addSubview:_scrollSeg];
    _scrollSeg.contentSize=CGSizeMake(kScreenSize.width, 30);
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor yellowColor]};
    
       NSArray *titles = @[@"要闻",@"时政",@"军事",@"体育",@"财经",@"社会",@"图闻"];
    _seg = [[UISegmentedControl alloc] initWithItems:titles];
    _seg.frame = CGRectMake(0, 0, kScreenSize.width, 30);

      [_seg setTitleTextAttributes:dict forState:UIControlStateNormal];
    [_scrollSeg addSubview:_seg];
    _seg.selectedSegmentIndex=0;

    
    [_seg addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger index = _scroll.contentOffset.x/_scroll.bounds.size.width;
    _seg.selectedSegmentIndex=index;
}
-(void)creatScroller {
    self.automaticallyAdjustsScrollViewInsets=NO;
    _scroll =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 94, kScreenSize.width, kScreenSize.height)];
    _scroll.backgroundColor=[UIColor redColor];
    
    _scroll.pagingEnabled=YES;
    _scroll.bounces=NO;
    _scroll.delegate=self;
    [self.view addSubview:_scroll];
   _scroll.contentSize=CGSizeMake(kScreenSize.width*7, kScreenSize.height);
    NSArray *classNames=@[@"HomeView1",@"HomeView2",@"HomeView3",@"HomeView4",@"HomeView5",@"HomeView6",@"HomeView7",@"HomeView8"];
    
    for (NSInteger i = 0; i < classNames.count; i++) {
       Class vcClass = NSClassFromString(classNames[i]);
        BaseView *vc = [[vcClass alloc] initWithFrame:CGRectMake(kScreenSize.width*i, 0, kScreenSize.width, kScreenSize.height-94)];
        
        [_scroll addSubview:vc];
    }

}


-(void)segClick:(UISegmentedControl *)seg {
    
    switch (seg.selectedSegmentIndex) {
        case 0:{
            _scroll.contentOffset=CGPointMake(0, 0);
            }
            
            break;
            
        case 1: {
            _scroll.contentOffset=CGPointMake(kScreenSize.width, 0);
           }
            break;
            
            
        case 2:{
            _scroll.contentOffset=CGPointMake(kScreenSize.width*2, 0);
            
            
        }
            
            break;
            
        case 3: {
            _scroll.contentOffset=CGPointMake(kScreenSize.width*3, 0);
            
        }
            break;
            
            
   
        case 4:{
            _scroll.contentOffset=CGPointMake(kScreenSize.width*4, 0);
            
            
        }
            
            break;
            
        case 5: {
            _scroll.contentOffset=CGPointMake(kScreenSize.width*5, 0);
            
        }
            break;
            
            
        case 6:{
            _scroll.contentOffset=CGPointMake(kScreenSize.width*6, 0);
            
            
        }
            
            break;
            
            
        default:
            break;
    }
}






//- (id)initWithViewControllers:(NSArray *)viewControllers {
//    if (self = [super init]) {
//        _viewControllers = viewControllers;
//        
//    }
//    return self;
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    return YES;
//}
//
//- (Topbar *)topbar {
//    if (!_topbar) {
//        _topbar = [[Topbar alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), kTopbarHeight)];
//        _topbar.backgroundColor = [UIColor  lightGrayColor];
//        
//        __block HomeViewController *_self = self;
//        _topbar.blockHandler = ^(NSInteger currentPage) {
//            [_self setCurrentPage:currentPage];
//        };
//        [self.view addSubview:_topbar];
//    }
//    return _topbar;
//}
//
//
//
//- (UIScrollView *)scrollView {
//    if (!_scrollView) {
//        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topbar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-kTopbarHeight)];
//        _scrollView.backgroundColor = [UIColor whiteColor];
//        _scrollView.delegate                       = self;
//        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.showsVerticalScrollIndicator   = NO;
//        _scrollView.bounces                        = NO;
//        _scrollView.pagingEnabled                  = YES;
//        [self.view addSubview:_scrollView];
//    }
//    return _scrollView;
//}
//
//
//- (void)setViewControllers:(NSArray *)viewControllers {
//    _viewControllers = [NSArray arrayWithArray:viewControllers];
//    CGFloat x = 0.0;
//    for (UIViewController *viewController in _viewControllers) {
//        [viewController willMoveToParentViewController:self];
//        viewController.view.frame = CGRectMake(x, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
//        [self.scrollView addSubview:viewController.view];
//        [viewController didMoveToParentViewController:self];
//        
//        x += CGRectGetWidth(self.scrollView.frame);
//        _scrollView.contentSize   = CGSizeMake(x, _scrollView.frame.size.width);
//    }
//    
//    self.topbar.titles = [_viewControllers valueForKey:@"title"];
//}
//
//- (void)setCurrentPage:(NSInteger)currentPage {
//    _currentPage = currentPage;
//    [self.scrollView setContentOffset:CGPointMake(_currentPage*_scrollView.frame.size.width, 0) animated:NO]; //
//}
//
//- (void)layoutSubViews
//{
//    CGFloat x = 0.0;
//    for (UIViewController *viewController in self.viewControllers) {
//        viewController.view.frame = CGRectMake(x, 64, _scrollView.frame.size.width, _scrollView.frame.size.height);
//        x += CGRectGetWidth(self.scrollView.frame);
//    }
//    self.scrollView.contentSize   = CGSizeMake(x, _scrollView.frame.size.width);
//  
//}
//
//#pragma mark - <UIScrollViewDelegate>
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSInteger currentPage = _scrollView.contentOffset.x / _scrollView.frame.size.width;
//    _topbar.currentPage   = currentPage;
//    _currentPage = currentPage;
//    [self callbackSubViewControllerWillShow];
//}
//
//// call back if scroll to special view controller
//- (void)callbackSubViewControllerWillShow {
//    UIViewController<ViewWillShow> *controller = [self.viewControllers objectAtIndex:self.currentPage];
//    if ([controller conformsToProtocol:@protocol(ViewWillShow)] && [controller respondsToSelector:@selector(ViewWillShow)]) {
//        [controller ViewWillShow];
//    }
//}
//
//
//
//
//
//
//- (void)viewDidLoad {
//    
//    [super viewDidLoad];
//    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//        
//    
//}
//
//
//- (void)viewDidUnload {
//    [super viewDidUnload];
//    self.tableView = nil;
//}
//

@end
