//
//  UIView+Addition.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 11/16/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BlurStyleExtraLight,
    BlurStyleLight,
    BlurStyleDark
}BlurStyle;

@interface UIView (Addition)

+ (UIView *)viewWithFrame:(CGRect)frame style:(BlurStyle)style;
+ (UIView *)blurViewWithFrame:(CGRect)frame style:(BlurStyle)style;

- (void)setNeedBorder:(BOOL)needBorder;

- (void)setC:(int)c;

@end
