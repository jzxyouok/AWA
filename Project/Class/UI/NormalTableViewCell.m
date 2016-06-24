//
//  NormalTableViewCell.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/25.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "NormalTableViewCell.h"

@implementation NormalTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = COLOR(2);
    
    [self setSelectedBackgroundColor:COLOR(14)];
    
    _separator = [self addBottomSeperatorWithColor:COLOR(3)];
}

@end
