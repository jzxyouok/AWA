//
//  AutoViewController.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/9/28.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "AutoViewController.h"

@interface AutoViewController ()

@end

@implementation AutoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _needNavigationBarAnimation = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.fd_prefersNavigationBarHidden = YES;
    
    self.navigationBar.visible = YES;
}

- (void)viewDidShow {
    [super viewDidShow];
    
    if (_needNavigationBarAnimation) {
        self.navigationBar.backgroundView.alpha = 0;
        self.navigationBar.titleLabel.alpha = 0;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.navigationBar];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_needNavigationBarAnimation) {
        return;
    }
    
    float alpha = scrollView.contentOffset.y / 100;
    
    self.navigationBar.titleLabel.alpha = alpha;
    
    self.navigationBar.backgroundView.alpha = alpha;
}

- (void)addBackBtn {
    [self.navigationBar addLeftBtnWithImageName:@"back" target:self action:@selector(backToPreviousViewController)];
}

@end
