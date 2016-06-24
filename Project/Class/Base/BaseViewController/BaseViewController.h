//
//  BaseViewController.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 13-8-28.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import "NavigationBar.h"

@interface BaseViewController : UIViewController

@property (nonatomic, copy) void(^completionAction)(id viewController);
@property (nonatomic, copy) void(^failAction)(id viewController);

@property (nonatomic, strong) UIImageView *bd_backgroundImageView;
@property (nonatomic, strong) NavigationBar *navigationBar;

@property (nonatomic, assign) BOOL isBottomPlayerViewVisiable;
@property (nonatomic, assign) BOOL needBlurBackground;

- (UINavigationController *)wrapWithNavigationController;

- (void)viewDidShow;

- (void)addBackBtn;

- (void)showLeftMenu;

@end
