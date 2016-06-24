//
//  UIView+BDConvenience.m
//  BDKit
//
//  Created by Suteki(67111677@qq.com) on 14-2-19.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "UIView+BDConvenience.h"

@implementation UIView (BDConvenience)

- (CGFloat)bd_left {
	return self.frame.origin.x;
}

- (void)setBd_left:(CGFloat)x {
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat)bd_top {
	return self.frame.origin.y;
}

- (void)setBd_top:(CGFloat)y {
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat)bd_right {
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setBd_right:(CGFloat)right {
	CGRect frame = self.frame;
	frame.origin.x = right - frame.size.width;
	self.frame = frame;
}

- (CGFloat)bd_bottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setBd_bottom:(CGFloat)bottom {
	CGRect frame = self.frame;
	frame.origin.y = bottom - frame.size.height;
	self.frame = frame;
}

- (CGFloat)bd_centerX {
	return self.center.x;
}

- (void)setBd_centerX:(CGFloat)centerX {
	self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)bd_centerY {
	return self.center.y;
}

- (void)setBd_centerY:(CGFloat)centerY {
	self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)bd_width {
	return self.frame.size.width;
}

- (void)setBd_width:(CGFloat)width {
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

- (CGFloat)bd_height {
	return self.frame.size.height;
}

- (void)setBd_height:(CGFloat)height {
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

- (CGFloat)bd_screenX {
	CGFloat x = 0;
	for (UIView* view = self; view; view = view.superview) {
		x += view.bd_left;
	}
	return x;
}

- (CGFloat)bd_screenY {
	CGFloat y = 0;
	for (UIView* view = self; view; view = view.superview) {
		y += view.bd_top;
	}
	return y;
}





#ifdef VIEW_CONVENIENCE

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)screenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}

- (CGFloat)screenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

#endif

@end
