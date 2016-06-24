//
//  AppManager.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 14/11/20.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <UIViewController+MMDrawerController.h>
#import <MMDrawerVisualState.h>

#import "AppManager.h"
#import "HomeViewController.h"
#import "SideViewController.h"

@interface AppManager()<UINavigationControllerDelegate> {
    
}

@end


@implementation AppManager

BD_ARC_SYNTHESIZE_SINGLETON_FOR_CLASS(AppManager)

- (id)centerViewController {
    HomeViewController *home = [HomeViewController sharedInstance];
    UINavigationController *centerVC = [home wrapWithNavigationController];
  
    return centerVC;
}

- (UINavigationController *)rootViewController {
    if (_rootViewController == nil) {
        SideViewController *side = [SideViewController spawn];
        UINavigationController *centerVC = [self centerViewController];
        
        MMDrawerController *drawer = [[MMDrawerController alloc] initWithCenterViewController:centerVC leftDrawerViewController:side];
        drawer.maximumLeftDrawerWidth = 280;
        drawer.showsShadow = NO;
        [drawer setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [drawer setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
        [drawer setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
            MMDrawerControllerDrawerVisualStateBlock block;
            block = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0];
            block(drawerController, drawerSide, percentVisible);
        }];
       
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:drawer];
        drawer.fd_prefersNavigationBarHidden = YES;
        
        _rootViewController = nc;
        _drawerController = drawer;
    }
    
    return _rootViewController;
}

@end
