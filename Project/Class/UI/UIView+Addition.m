//
//  UIView+Addition.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 11/16/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import "UIView+Addition.h"
#import "UIColor+Addition.h"

@implementation UIView (Addition)

+ (UIView *)viewWithFrame:(CGRect)frame style:(BlurStyle)style {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    switch (style) {
        case BlurStyleDark:
            view.backgroundColor = COLOR(2);
            view.alpha = 1;
            break;
        case BlurStyleExtraLight:
        case BlurStyleLight:
            view.backgroundColor = COLOR(6);
            view.alpha = 0.9;
            break;
        default:
            break;
    }
    
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    return view;
}

+ (UIView *)blurViewWithFrame:(CGRect)frame style:(BlurStyle)style {
    UIView *blurView = nil;
    
    if (IOS8_OR_LATER) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyle)style];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        
        blurView = effectView;
    }else {
        UIView *view = [[UIView alloc] init];
        switch (style) {
            case BlurStyleDark:
                view.backgroundColor = COLOR(2);
                view.alpha = 1;
                break;
            case BlurStyleExtraLight:
            case BlurStyleLight:
                view.backgroundColor = COLOR(6);
                view.alpha = 0.9;
                break;
            default:
                break;
        }
        
        blurView = view;
    }
    
    blurView.frame = frame;
    blurView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    return blurView;
}

- (void)setNeedBorder:(BOOL)needBorder {
    if (needBorder) {
        self.borderColor = COLOR(5);
        self.borderWidth = 0.5;
    }else {
        self.borderColor = [UIColor clearColor];
        self.borderWidth = 0;
    }
}

- (void)setC:(int)c {
    UIColor *color = [UIColor colorWithNumber:c];
    self.backgroundColor = color;
}

@end
