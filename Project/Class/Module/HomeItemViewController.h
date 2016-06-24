//
//  HomeItemViewController.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/3.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "BaseViewController.h"
#import "GlassViewController.h"

@interface HomeItemViewController : GlassViewController

@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, copy) NSString *itemSubtitle;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, assign) UIScrollView *scrollView;

@end
