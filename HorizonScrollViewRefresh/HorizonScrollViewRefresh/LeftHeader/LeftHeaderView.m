//
//  LeftHeaderView.m
//  HorizonScrollViewRefresh
//
//  Created by anxindeli on 2018/3/29.
//  Copyright © 2018年 anxindeli. All rights reserved.
//

#import "LeftHeaderView.h"

@interface LeftHeaderView ()

@property (nonatomic, strong) UILabel *conText;//刷新文案（如：拉下刷新、松手刷新、正在刷新）
@property (nonatomic, strong) UIImageView *conImageView;//刷新图标（用于动画）
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;//菊花

@end
@implementation LeftHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.conImageView];
        [self addSubview:self.conText];
        [self addSubview:self.loadingView];
    }
    return self;
}
#pragma mark - System Method
- (void)layoutSubviews{
    
    
    CGPoint point = self.center;
    CGFloat width = self.bounds.size.width;
    _conImageView.center = CGPointMake(width+point.x, point.y + 30);
    _conText.center = CGPointMake(width+point.x, point.y - 20);
    _loadingView.center = _conImageView.center;
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    [super willMoveToSuperview:newSuperview];
    self.frame = CGRectMake(-60, 0, 60, CGRectGetHeight(newSuperview.bounds));
}
- (void)prepare{
    
    self.stateTitles = @{
                         @(RefreshStateIdle):@"右拉可以刷新",
                         @(RefreshStatePulling):@"松开立即刷新",
                         @(RefreshStateRefreshing):@"正在刷新",
                         @(RefreshStateNoMoreData):@"没有更多数据了",
                         };

}
#pragma mark - GETTER
- (UILabel *)conText{
    
    if (!_conText) {
        
        _conText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        _conText.font = [UIFont systemFontOfSize:12];
        _conText.textColor = [UIColor grayColor];
        _conText.numberOfLines = 0;
        _conText.textAlignment = NSTextAlignmentCenter;
    }
    return _conText;
}
- (UIImageView *)conImageView{
    
    if (!_conImageView) {
        
        _conImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _conImageView.image = [UIImage imageNamed:@"right1.png"];
    }
    return _conImageView;
}
- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadingView.hidesWhenStopped = YES;
    }
    return _loadingView;
}
#pragma mark  ======================================================
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    
    [super scrollViewContentOffsetDidChange:change];
    if (self.state == RefreshStateRefreshing) return;

    CGFloat contentX = self.scrollView.contentOffset.x;

    // 在刷新的refreshing状态
    if (self.state == RefreshStateRefreshing) {
        if (self.window == nil) return;
        
        [self.scrollView setContentInset:UIEdgeInsetsMake(0, -60, 0, 0)];
        return;
    }
    
    if (self.scrollView.isDragging) {//正在拖拽
        
        if (contentX>-60&&contentX<0) {
            self.state = RefreshStateIdle;
        }else if (contentX<-60){
            self.state = RefreshStatePulling;
        }
    }else if (self.state == RefreshStatePulling){//拖拽&松手
        [self beginRefreshing];
    }else{
        
        if (contentX>-60&&contentX<0) {
            self.state = RefreshStateIdle;
        }else if (contentX<=-60){
            self.state = RefreshStateRefreshing;
        }
        
    }
    
    
}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    
    [super scrollViewContentSizeDidChange:change];

}
- (void)beginRefreshing{
    
    self.state = RefreshStateRefreshing;
}
- (void)endRefreshing{
    
    self.state = RefreshStateIdle;
}
- (void)setState:(RefreshState)state{
    
    [super setState:state];
    self.conText.text = self.stateTitles[@(state)];
    
    if (state == RefreshStateIdle) {
        //箭头动画
        self.conImageView.transform = CGAffineTransformIdentity;
        self.conImageView.hidden = NO;
        [self.loadingView stopAnimating];
        self.loadingView.alpha = 0.0f;
        [UIView animateWithDuration:0.25 animations:^{
            self.conImageView.transform = CGAffineTransformIdentity;
        }];
        
        //scrollview 设置
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        } completion:^(BOOL finished) {
        }];
    
    }else if (state == RefreshStatePulling){
        
        //箭头翻转动画
        self.conImageView.hidden = NO;
        [self.loadingView stopAnimating];
        [UIView animateWithDuration:0.25 animations:^{
            self.conImageView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    }else if (state == RefreshStateRefreshing) {
        
        //箭头隐藏
        self.conImageView.hidden = YES;
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];

        //scrollview 设置
        [UIView animateWithDuration:0.25 animations:^{
            CGFloat top = 60;
            // 增加滚动区域top
            [self.scrollView setContentInset:UIEdgeInsetsMake(0, top, 0, 0)];
            // 设置滚动位置
            [self.scrollView setContentOffset:CGPointMake(-top, 0) animated:NO];
        } completion:^(BOOL finished) {
        }];
    }
}
#pragma mark - 公共方法
- (void)noticeNoMoreData
{
    self.state = RefreshStateNoMoreData;
}

- (void)resetNoMoreData
{
    self.state = RefreshStateIdle;
}
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action{
    
    LeftHeaderView *cmp = [[self alloc] initWithFrame:CGRectZero];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}
@end
