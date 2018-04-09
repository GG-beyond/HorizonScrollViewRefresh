//
//  RightHeaderView.h
//  HorizonScrollViewRefresh
//
//  Created by anxindeli on 2018/4/9.
//  Copyright © 2018年 anxindeli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonHeaderView.h"

@interface RightHeaderView : CommonHeaderView
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@end
