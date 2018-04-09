//
//  CommonHeaderView.m
//  HorizonScrollViewRefresh
//
//  Created by anxindeli on 2018/3/29.
//  Copyright © 2018年 anxindeli. All rights reserved.
//

#import "CommonHeaderView.h"

@implementation CommonHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self prepare];
    }
    return self;
}
- (void)prepare{
    //默认
    self.stateTitles = @{
                         @(RefreshStateIdle):@"右拉可以刷新",
                         @(RefreshStatePulling):@"松开立即刷新",
                         @(RefreshStateRefreshing):@"正在刷新",
                         @(RefreshStateNoMoreData):@"没有更多数据了",
                         };
}
- (void)layoutSubviews{
    
}
- (void)setState:(RefreshState)state{
    _state = state;
}
//当自己重写一个UIView的时候有可能用到这个方法,当本视图的父类视图改变的时候,系统会自动的执行这个方法.newSuperview是本视图的新父类视图.newSuperview有可能是nil.

- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    // 如果不是UIScrollView，不做任何事情
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    // 旧的父控件移除监听
    [self removeObservers];

    if (newSuperview) {//新的父控件改变
        _scrollView = (UIScrollView *)newSuperview;
        [self addObservers];
    }
}
#pragma mark - KVO监听
- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:options context:nil];
//    self.pan = self.scrollView.panGestureRecognizer;
//    [self.pan addObserver:self forKeyPath:MJRefreshKeyPathPanState options:options context:nil];
}
- (void)removeObservers
{
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    [self.superview removeObserver:self forKeyPath:@"contentSize"];
//    [self.pan removeObserver:self forKeyPath:MJRefreshKeyPathPanState];
//    self.pan = nil;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self scrollViewContentSizeDidChange:change];
    }
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self scrollViewContentOffsetDidChange:change];
    }
    
}
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    self.target = target;
    self.action = action;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}
- (void)beginRefreshing{}
- (void)endRefreshing{}
@end
