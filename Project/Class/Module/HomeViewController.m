//
//  HomeViewController.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/9/25.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "HomeViewController.h"
#import <UIViewController+MMDrawerController.h>


#import "TrendingViewController.h"
#import "DiscoveryViewController.h"
#import "GenreViewController.h"
#import "MoodViewController.h"

#import "AlbumViewController.h"
#import "AlbumsListViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, assign) int page;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end


@implementation HomeViewController

BD_ARC_SYNTHESIZE_SINGLETON_FOR_CLASS(HomeViewController)

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(2);
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self addBackground];
    
    [self addScrollView];
    [self addPageControl];
    
    [self addMenuBtn];
    [self addAwaLabel];
    
    NSArray *viewControllers = @[[TrendingViewController spawn],
                                 [DiscoveryViewController spawn],
                                 [GenreViewController spawn],
                                 [MoodViewController spawn]];
    
    for (int i=0; i<viewControllers.count; i++) {
        [self configVC:viewControllers[i] atIndex:i];
    }
    
    [self.scrollView setContentSize:CGSizeMake(viewControllers.count * _scrollView.width, 0)];
    
    _pageControl.numberOfPages = self.childViewControllers.count;
    
    [self configTransition];
    
    [self bk_performBlock:^(id obj) {
        [self scrollViewDidEndDecelerating:_scrollView];
    } afterDelay:0.1];
}

- (void)configVC:(HomeItemViewController *)vc atIndex:(int)index {
    UINavigationController *nc = [vc wrapWithNavigationController];
    [self addChildViewController:nc];
    [self.scrollView addSubview:nc.view];
    
    [nc.view setFrame:CGRectOffset(nc.view.bounds, index * _scrollView.width, 0)];
}

- (void)addScrollView {
    CGFloat blackSideBarWidth = 2;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width + 2*blackSideBarWidth, self.view.height)];
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.scrollsToTop = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [scrollView.panGestureRecognizer addTarget:self action:@selector(transferPanGesture:)];
   
    [self.view addSubview:scrollView];
    
    _scrollView = scrollView;
}

- (void)addBackground {
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    background.image = [UIImage imageNamed:@"background_5.jpg"];
    [self.view addSubview:background];
}

- (void)addMenuBtn {
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"list_icon"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(showLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuBtn];
}

- (void)transferPanGesture:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateCancelled ||
        gesture.state == UIGestureRecognizerStateEnded) {
        [self.mm_drawerController panGestureCallback:gesture];
        return;
    }
    
    if(_scrollView.contentOffset.x <= 0) {
        [self.mm_drawerController panGestureCallback:gesture];
    } else if(_scrollView.contentOffset.x >= _scrollView.contentSize.width - _scrollView.bounds.size.width) {
        
    }
}

- (void)addPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.width - 95, 50, 100, 10)];
    [self.view addSubview:pageControl];
    
    _pageControl = pageControl;
}

- (void)addAwaLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width - 95, 20, 100, 30)];
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"AWA";
    
    [self.view addSubview:label];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat ratio = scrollView.contentOffset.x/scrollView.frame.size.width;
    _page = (int)floor(ratio);
    
    _pageControl.currentPage = _page;
    
    _scrollView.bounces = ratio > 1;
    
    for (int i = 0; i < self.childViewControllers.count; i++) {
        if (ratio > i - 1 && ratio < i + 1) {
            UINavigationController *nc = self.childViewControllers[i];
            GlassViewController *vc =  nc.viewControllers.firstObject;
            [vc.glassScrollView scrollHorizontalRatio:-ratio + i];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    for (int i=0; i<self.childViewControllers.count; i++) {
        UINavigationController *nc = self.childViewControllers[i];
        HomeItemViewController *vc = nc.viewControllers.firstObject;
        vc.scrollView.scrollsToTop = (i == _page);
    }
}

- (void)configTransition {
    [ASFSharedViewTransition addTransitionWithFromViewControllerClass:[HomeViewController class]
                                                ToViewControllerClass:[AlbumViewController class]
                                             WithNavigationController:self.navigationController
                                                         WithDuration:0.3f];
    
    [ASFSharedViewTransition addTransitionWithFromViewControllerClass:[HomeViewController class]
                                                ToViewControllerClass:[AlbumsListViewController class]
                                             WithNavigationController:self.navigationController
                                                         WithDuration:0.3f];
}

- (UIView *)sharedView {
    return _sharedView;
}

- (ASFSharedViewTransitionStyle)transitionStyle {
    int page = _scrollView.contentOffset.x / _scrollView.width;
    switch (page) {
        case 2:
            return ASFSharedViewTransitionStyleFade;
        default:
            return ASFSharedViewTransitionStylePush;
    }
}

@end
