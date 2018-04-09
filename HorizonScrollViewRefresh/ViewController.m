//
//  ViewController.m
//  HorizonScrollViewRefresh
//
//  Created by anxindeli on 2018/3/28.
//  Copyright © 2018年 anxindeli. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+HorizonRefresh.h"
#import "LeftHeaderView.h"
#import "RightHeaderView.h"
@interface ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *refreshControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.refreshControl];
    
}
- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 100, 300, 300)];
//        _scrollView.contentSize = CGSizeMake(600, 300);
        _scrollView.backgroundColor = [UIColor orangeColor];
        _scrollView.bounces = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.leftHeader = [LeftHeaderView headerWithRefreshingTarget:self refreshingAction:@selector(doRefresh)];
        _scrollView.rightHeader = [RightHeaderView headerWithRefreshingTarget:self refreshingAction:@selector(doRefresh)];

    }
    return _scrollView;
}
- (void)doRefresh{
    
}

//结束刷新按钮
- (UIButton *)refreshControl{
    
    if (!_refreshControl) {
        
        _refreshControl = [UIButton buttonWithType:UIButtonTypeCustom];
        _refreshControl.frame = CGRectMake(100, 500, 100, 40);
        [_refreshControl setBackgroundColor:[UIColor blueColor]];
        [_refreshControl setTitle:@"刷新结束" forState:UIControlStateNormal];
        [_refreshControl addTarget:self action:@selector(doStop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshControl;
}
- (void)doStop{
    
    [_scrollView.leftHeader endRefreshing];
    [_scrollView.rightHeader endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
