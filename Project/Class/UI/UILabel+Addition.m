//
//  UILabel+Addition.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/25.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "UILabel+Addition.h"
#import "UIColor+Addition.h"

@implementation UILabel (Addition)

- (void)setC:(int)c {
    UIColor *color = [UIColor colorWithNumber:c];
    self.textColor = color;
}

@end
