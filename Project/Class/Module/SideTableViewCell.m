//
//  SideTableViewCell.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/4.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "SideTableViewCell.h"

@implementation SideInfo

+ (id)infoWithTitle:(NSAttributedString *)title icon:(NSString *)icon {
    id info = [[self class] spawn];
    [info setTitle:title];
    [info setIcon:icon];
    
    return info;
}

- (Class)cellClass {
    return [SideTableViewCell class];
}

@end


@implementation SideTableViewCell

- (BOOL)shouldUpdateCellWithObject:(SideInfo *)object {
    _icon.image = [UIImage imageNamed:object.icon];
    _titleLabel.attributedText = object.title;
    
    return YES;
}

@end
