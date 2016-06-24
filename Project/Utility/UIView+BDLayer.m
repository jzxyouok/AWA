//
//  UIView+Layer.m
//  BDKit
//
//  Created by Suteki(67111677@qq.com) on 14-6-29.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "UIView+BDLayer.h"

@implementation UIView (BDLayer)

- (float)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(float)borderWidth {
    self.layer.borderWidth = borderWidth;
}



- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}



- (float)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(float)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}


@end
