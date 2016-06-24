//
//  BaseViewController.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 13-8-28.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface BaseViewController () {
    BOOL _isViewDidLoad;
}

@end

@implementation BaseViewController

- (UINavigationController *)wrapWithNavigationController {
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self];
    return nc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(2);
}

- (void)viewDidShow {
    BaseViewController *firstVC = self.navigationController.viewControllers.firstObject;
    if (firstVC != self &&
        firstVC != nil) {
        [self addBackBtn];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!_isViewDidLoad) {
        [self performSelector:@selector(viewDidShow) withObject:nil afterDelay:0];
        _isViewDidLoad = YES;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Other

- (void)setNeedBlurBackground:(BOOL)needBlurBackground {
    UIView *blurView = [UIView viewWithFrame:self.view.bounds style:BlurStyleDark];
    
    [self.view insertSubview:blurView aboveSubview:self.bd_backgroundImageView];
}

- (UIImageView *)bd_backgroundImageView {
    if (_bd_backgroundImageView == nil) {
        _bd_backgroundImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bd_backgroundImageView.top -= NAV_BAR_HEIGHT;
        _bd_backgroundImageView.contentMode = UIViewContentModeScaleToFill;
        _bd_backgroundImageView.clipsToBounds = YES;
        [self.view insertSubview:_bd_backgroundImageView atIndex:0];
    }
    return _bd_backgroundImageView;
}

- (void)addBackBtn {
    [self setNavigationButtonWithImgName:@"back"
                    highlightedImageName:nil
                                  action:@selector(backToPreviousViewController)
                                  isLeft:YES
                         autoEdgeInserts:YES];
}

- (void)showLeftMenu {
    if (self.mm_drawerController.visibleLeftDrawerWidth > 0) {
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    }else {
        [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
}

- (NavigationBar *)navigationBar {
    if (_navigationBar == nil) {
        NavigationBar *navigationBar = [NavigationBar barWithWidth:self.view.width];
        navigationBar.visible = NO;
        [RACObserve(self, title) subscribeNext:^(id x) {
            navigationBar.titleLabel.text = x;
        }];

        [self.view addSubview:navigationBar];
        
        _navigationBar = navigationBar;
    }
    
    return _navigationBar;
}

@end
