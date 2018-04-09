//
//  UIScrollView+HorizonRefresh.h
//  HorizonScrollViewRefresh
//
//  Created by anxindeli on 2018/3/28.
//  Copyright © 2018年 anxindeli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftHeaderView.h"
#import "RightHeaderView.h"

@interface UIScrollView (HorizonRefresh)
@property (nonatomic, strong) LeftHeaderView *leftHeader;
@property (nonatomic, strong) RightHeaderView *rightHeader;

@end
