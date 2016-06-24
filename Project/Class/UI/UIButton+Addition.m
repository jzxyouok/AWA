//
//  UIButton+Addition.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/25.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "UIButton+Addition.h"

@implementation UIButton (Addition)

- (void)setC:(int)c {
    UIColor *color = [UIColor colorWithNumber:c];
    [self setTitleColor:color forState:UIControlStateNormal];
}

@end
