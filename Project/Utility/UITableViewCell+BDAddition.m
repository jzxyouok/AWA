//
//  UITableViewCell+Addition.m
//  HuanYin
//
//  Created by Suteki(67111677@qq.com) on 15/11/5.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "UITableViewCell+BDAddition.h"

@implementation UITableViewCell (BDAddition)

- (void)setSelectedBackgroundColor:(UIColor *)color {
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bd_width, self.bd_height - 1)];
    selectedView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    selectedView.backgroundColor = color;
    self.selectedBackgroundView = selectedView;
}

@end
