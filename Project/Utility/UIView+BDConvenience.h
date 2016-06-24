//
//  UIView+BDConvenience.h
//  BDKit
//
//  Created by Suteki(67111677@qq.com) on 14-2-19.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VIEW_CONVENIENCE

@interface UIView (BDConvenience)

@property (nonatomic, assign) CGFloat bd_left;
@property (nonatomic, assign) CGFloat bd_top;
@property (nonatomic, assign) CGFloat bd_right;
@property (nonatomic, assign) CGFloat bd_bottom;

@property (nonatomic, assign) CGFloat bd_width;
@property (nonatomic, assign) CGFloat bd_height;

@property (nonatomic, assign) CGFloat bd_centerX;
@property (nonatomic, assign) CGFloat bd_centerY;

@property (nonatomic, readonly) CGFloat bd_screenX;
@property (nonatomic, readonly) CGFloat bd_screenY;

#ifdef VIEW_CONVENIENCE

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, readonly) CGFloat screenX;
@property (nonatomic, readonly) CGFloat screenY;

#endif

@end
