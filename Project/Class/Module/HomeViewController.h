//
//  HomeViewController.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/9/25.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController

BD_ARC_SYNTHESIZE_SINGLETON_FOR_HEADER(HomeViewController)

@property (nonatomic, strong) UIView *sharedView;

@end
