//
//  UIColor+BDAddition.h
//  BDKit
//
//  Created by Suteki(67111677@qq.com) on 14-2-19.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BDAddition)

+ (UIColor *)colorWithHexValue:(NSUInteger)hex;
+ (UIColor *)colorWithHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)colorWithShortHexValue:(NSUInteger)hex;
+ (UIColor *)colorWithShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)colorWithString:(NSString *)string; // {#FFF|#FFFFFF|#FFFFFFFF}{,0.6}

@end
