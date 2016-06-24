//
//  UIColor+Addition.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/25.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLOR(__X__) [UIColor colorWithNumber:__X__]

@interface UIColor (Addition)

+ (UIColor *)colorWithNumber:(int)number;

@end
