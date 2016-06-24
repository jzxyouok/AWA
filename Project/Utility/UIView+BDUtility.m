//
//  UIView+BDUtility.m
//  BDKit
//
//  Created by Suteki(67111677@qq.com) on 14-2-20.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "UIView+BDUtility.h"

@implementation UIView (BDUtility)

//visibility

@dynamic visible;

- (BOOL)visible {
	return self.hidden ? NO : YES;
}

- (void)setVisible:(BOOL)flag {
	self.hidden = flag ? NO : YES;
}

//snapshot

- (UIImage *)snapshotImage {
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

//responder chain

- (UIViewController *)firstViewController {
    id responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]])
        {
            return responder;
        }
    }
    return nil;
}

- (void)shakeView {
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
    shake.autoreverses = YES;
    shake.repeatCount = 2.0f;
    shake.duration = 0.07f;
    
    [self.layer addAnimation:shake forKey:nil];
}

- (void)pulseViewWithTime:(CGFloat)seconds
{
    [UIView animateWithDuration:seconds/6 animations:^{
        [self setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
    } completion:^(BOOL finished) {
        if(finished)
        {
            [UIView animateWithDuration:seconds/6 animations:^{
                [self setTransform:CGAffineTransformMakeScale(0.96, 0.96)];
            } completion:^(BOOL finished) {
                if(finished)
                {
                    [UIView animateWithDuration:seconds/6 animations:^{
                        [self setTransform:CGAffineTransformMakeScale(1.03, 1.03)];
                    } completion:^(BOOL finished) {
                        if(finished)
                        {
                            [UIView animateWithDuration:seconds/6 animations:^{
                                [self setTransform:CGAffineTransformMakeScale(0.985, 0.985)];
                            } completion:^(BOOL finished) {
                                if(finished)
                                {
                                    [UIView animateWithDuration:seconds/6 animations:^{
                                        [self setTransform:CGAffineTransformMakeScale(1.007, 1.007)];
                                    } completion:^(BOOL finished) {
                                        if(finished)
                                        {
                                            [UIView animateWithDuration:seconds/6 animations:^{
                                                [self setTransform:CGAffineTransformMakeScale(1, 1)];
                                            } completion:^(BOOL finished) {
                                                if(finished)
                                                {
                                                    
                                                }
                                            }];
                                        }
                                    }];
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}

- (UIView *)addBottomSeperatorWithColor:(UIColor *)color {
    UIImageView *separator = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bd_height - 1, self.bd_width, 1)];
    separator.backgroundColor = color;
    separator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    separator.image = [UIImage imageFromColor:color];
    
    [self addSubview:separator];
    
    return separator;
}

- (void)addTopSeperatorWithColor:(UIColor *)color {
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bd_width, 1)];
    separator.backgroundColor = color;
    separator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:separator];
}

- (void)setIsCircle:(BOOL)isCircle {
    self.cornerRadius = isCircle ? self.bd_width / 2 : 0;
}

@end
