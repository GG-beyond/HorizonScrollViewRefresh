//
//  UIScrollView+HorizonRefresh.m
//  HorizonScrollViewRefresh
//
//  Created by anxindeli on 2018/3/28.
//  Copyright © 2018年 anxindeli. All rights reserved.
//

#import "UIScrollView+HorizonRefresh.h"
#import <objc/runtime.h>

// 定义关联的key
static const char *key="leftHeader";
static const char *keyR="rightHeader";

@implementation UIScrollView (HorizonRefresh)

- (void)setLeftHeader:(LeftHeaderView *)leftHeader{
    
    if (leftHeader!=self.leftHeader) {
        
        [self.leftHeader removeFromSuperview];
        [self insertSubview:leftHeader atIndex:0];
        
        [self willChangeValueForKey:@"mj_header"]; // KVO
        objc_setAssociatedObject(self, key, leftHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"mj_header"]; // KVO
    }
}
- (LeftHeaderView *)leftHeader{
    return objc_getAssociatedObject(self, key);
}
- (void)setRightHeader:(RightHeaderView *)rightHeader{
    
    if (rightHeader!=self.rightHeader) {
        
        [self.rightHeader removeFromSuperview];
        [self insertSubview:rightHeader atIndex:0];
        
        [self willChangeValueForKey:@"mj_header"]; // KVO
        objc_setAssociatedObject(self, keyR, rightHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"mj_header"]; // KVO
    }
}
- (RightHeaderView *)rightHeader{
    
    return objc_getAssociatedObject(self, keyR);
}
#pragma mark - method
@end
