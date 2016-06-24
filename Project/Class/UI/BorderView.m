//
//  BorderView.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 12/5/14.
//  Copyright (c) 2014 Baidu. All rights reserved.
//

#import "BorderView.h"

@implementation BorderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.borderColor = COLOR(5);
    self.borderWidth = 0.5;
}


@end
