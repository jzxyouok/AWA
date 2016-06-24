//
//  UIImage+BDAddition.h
//  BDKit
//
//  Created by Suteki(67111677@qq.com) on 14-2-19.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BDAddition)

+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageFromColor:(UIColor *)color;   // Size: 1x1

+ (UIImage *)imageNoCacheNamed:(NSString *)name;
+ (UIImage *)stretchableImage:(NSString *)name;

- (UIImage *)stretched;
- (UIImage *)stretchedWithInsets:(UIEdgeInsets)capInsets  NS_AVAILABLE_IOS(5_0);

- (UIImage *)scaleToSize:(CGSize)size;
- (UIImage *)scaleAspectToSize:(CGSize)size;

- (UIImage *)grayscale;

- (UIColor *)patternColor;

- (UIImage *)merge:(UIImage *)image;

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

- (UIImage *)blurImageWithBlur:(CGFloat)blur;   // need import framework:Accelerate

@end
