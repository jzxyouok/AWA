//
//  AppManager.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 14/11/20.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject

BD_ARC_SYNTHESIZE_SINGLETON_FOR_HEADER(AppManager)

@property (nonatomic, strong) MMDrawerController *drawerController;

@property (nonatomic, strong) UINavigationController *rootViewController;

@end
