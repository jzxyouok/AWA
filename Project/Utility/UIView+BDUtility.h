//
//  UIView+BDUtility.h
//  BDKit
//
//  Created by Suteki(67111677@qq.com) on 14-2-20.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BDUtility)

@property (nonatomic, assign) BOOL visible;

- (UIImage *)snapshotImage;

- (UIViewController *)firstViewController;

- (void)shakeView;

- (void)pulseViewWithTime:(CGFloat)seconds;

- (void)addTopSeperatorWithColor:(UIColor *)color;
- (UIView *)addBottomSeperatorWithColor:(UIColor *)color;

- (void)setIsCircle:(BOOL)isCircle;


@end
