//
//  CenterViewController.m
//  choutixiaoguo
//
//  Created by jxmm on 16/1/13.
//  Copyright © 2016年 jinxiang. All rights reserved.
//

#import "CenterViewController.h"

#import "LeftVC2.h"

#import "ScriptViewController.h"
#import "SerialsViewController.h"


@interface CenterViewController()
{
    LeftVC2 *vc1;
    SerialsViewController *vc2;
    ScriptViewController *vc3;
}

@end

@implementation CenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setIndex:0];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        
        [self prefersStatusBarHidden];
        
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
        
    }
    
}

- (BOOL)prefersStatusBarHidden

{
    
    return YES;
    
}


-(void)setIndex:(int)index {
    
    _index=index;
    if (index==0) {
        if (vc1==nil) {
            vc1=[[LeftVC2 alloc] init];
            [self  addChildViewController:vc1];
        }
        _targetVC=vc1;
    }if (index==1) {
        
   
        
        if (vc2==nil) {
            vc2=[[SerialsViewController  alloc] init];
            [self  addChildViewController:vc2];
        }
        _targetVC=vc2;
        
    } if (index==2) {

        if (vc3==nil) {
            vc3=[[ScriptViewController alloc] init];
            
            [self addChildViewController:vc3];
        }
        
        _targetVC=vc3;
    }
    
    
    
    if (_currentVC==nil&&index==0) {
        [self.view addSubview:vc1.view];
        [vc1  didMoveToParentViewController:self];
        _currentVC=vc1;
    }
    
    if ((_currentVC==vc1&&index==0)||(_currentVC==vc2&&index==1)||(_currentVC==vc3&&index==2)) {
        return;
    }
    [self transitionFromViewController:_currentVC toViewController:_targetVC duration:.5 options:UIViewAnimationOptionTransitionNone animations:^{
        
    } completion:^(BOOL finished) {
        if (finished) {
            _currentVC=_targetVC;
        }
    }];
 
}

@end
