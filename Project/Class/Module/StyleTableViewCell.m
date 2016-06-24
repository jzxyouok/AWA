//
//  MoodTableViewCell.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/4.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "StyleTableViewCell.h"

@implementation StyleTableViewCell

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view {
    CGRect rectInSuperview = [tableView convertRect:self.frame toView:view];
    
    float distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
    float difference = CGRectGetHeight(self.parallaxImage.frame) - CGRectGetHeight(self.frame);
    float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
    
    CGRect imageRect = self.parallaxImage.frame;
    imageRect.origin.y = -(difference/2)+move;
    self.parallaxImage.frame = imageRect;
}


- (void)reloadInfo:(StyleInfo *)info {
    _icon.image = [UIImage imageNamed:info.icon];
    _titleLabel.text = info.name;
}

@end
