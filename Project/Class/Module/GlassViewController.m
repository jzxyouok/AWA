//
//  GlassViewController.m
//  BTGlassScrollViewExample
//
//  Created by Suteki(67111677@qq.com) on 15/9/25.
//  Copyright © 2015年 Byte. All rights reserved.
//

#import "GlassViewController.h"

@interface GlassViewController ()<BTGlassScrollViewDelegate>

@end

@implementation GlassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)configBackgroundImage:(UIImage *)backgroundImage foregroundScrollView:(UIScrollView *)foregroundScrollView {
    if (_glassScrollView) {
        [_glassScrollView removeFromSuperview];
    }
    _glassScrollView = [[BTGlassScrollView alloc] initWithFrame:self.view.bounds backgroundImage:backgroundImage foregroundScrollView:foregroundScrollView];
    foregroundScrollView.delegate = self;
    [self.view insertSubview:_glassScrollView atIndex:0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    [_glassScrollView scrollViewDidScroll:scrollView];
}

@end
