//
//  UIColor+Addition.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/25.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "UIColor+Addition.h"

static NSDictionary *colors = nil;

@implementation UIColor (Addition)

+ (UIColor *)colorWithNumber:(int)number {
    if (colors == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ColorConfig" ofType:@"plist"];
        colors = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
    NSString *colorValue = colors[FORMAT(@"%d", number)];

    return [UIColor colorWithString:colorValue];
}

@end
