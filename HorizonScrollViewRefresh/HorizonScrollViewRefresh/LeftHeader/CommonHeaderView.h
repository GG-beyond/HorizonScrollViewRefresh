//
//  CommonHeaderView.h
//  HorizonScrollViewRefresh
//
//  Created by anxindeli on 2018/3/29.
//  Copyright © 2018年 anxindeli. All rights reserved.
//

#import <UIKit/UIKit.h>
static CGFloat HEADERWIDTH = 60.0f;

/** 刷新控件的状态 */ //(抄 MJ)
typedef NS_ENUM(NSInteger, RefreshState) {
    /** 普通闲置状态 */
    RefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    RefreshStatePulling,
    /** 正在刷新中的状态 */
    RefreshStateRefreshing,
    /** 即将刷新的状态 */
    RefreshStateWillRefresh,
    /** 所有数据加载完毕，没有更多的数据了 */
    RefreshStateNoMoreData
};

@interface CommonHeaderView : UIView
@property (nonatomic, readonly) UIScrollView *scrollView;
@property (assign, nonatomic) RefreshState state;
@property (nonatomic, strong) NSDictionary *stateTitles;
@property (nonatomic, assign) SEL action;
@property (nonatomic, weak) id target;
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;
//准备
- (void)prepare;
/** 进入刷新状态 */
- (void)beginRefreshing;
/** 结束刷新状态 */
- (void)endRefreshing;

/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的contentSize发生改变的时候调用 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;

@end
