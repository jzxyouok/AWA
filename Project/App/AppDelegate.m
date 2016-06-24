//
//  AppDelegate.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 14-11-10.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "AppDelegate.h"
#import "AppManager.h"

@interface AppDelegate()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupAppearance];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [AppManager sharedInstance].rootViewController;
    
    return YES;
}

- (void)setupAppearance {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageFromColor:COLOR(2)]
                                       forBarMetrics:UIBarMetricsDefault];
    
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    
    NSDictionary *textAttributes = @{NSForegroundColorAttributeName :   COLOR(8) ,
                                     NSFontAttributeName            :   [UIFont systemFontOfSize:18]};
    [UINavigationBar appearance].titleTextAttributes = textAttributes;
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

@end
