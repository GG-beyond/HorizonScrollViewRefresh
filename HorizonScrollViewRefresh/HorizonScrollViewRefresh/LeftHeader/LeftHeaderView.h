//
//  LeftHeaderView.h
//  HorizonScrollViewRefresh
//
//  Created by anxindeli on 2018/3/29.
//  Copyright © 2018年 anxindeli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonHeaderView.h"

@interface LeftHeaderView : CommonHeaderView

+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 结束刷新 **/
- (void)endRefreshing;
/** 提示没有更多的数据 */
- (void)noticeNoMoreData;
/** 重置没有更多的数据（消除没有更多数据的状态） */
- (void)resetNoMoreData;

@end
