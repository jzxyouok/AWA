//
//  MusicTableViewCell.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/5.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "MusicTableViewCell.h"

@implementation MusicTableViewCell

- (void)reloadInfo:(MusicInfo *)info {
    _titleLabel.text = info.name;
    
    _subtitleLabel.text = info.singer;
    
    _icon.image = [UIImage imageNamed:info.icon];
}

@end
