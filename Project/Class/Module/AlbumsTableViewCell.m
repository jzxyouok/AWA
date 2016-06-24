//
//  AlbumsTableViewCell.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/3.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "AlbumsTableViewCell.h"

@implementation AlbumsTableViewCell

- (void)awakeFromNib {
    self.miniumScale = 0.85;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.scaleView.transform = CGAffineTransformMakeScale(self.miniumScale, self.miniumScale);
}

- (void)transformCellForScale:(float)scale {
    self.scaleView.transform = CGAffineTransformMakeScale(1.0 - scale, 1.0 - scale);
}

- (void)reloadInfo:(AlbumInfo *)info {
    _titleLabel.text = info.name;
    _descLabel.text = info.desc;
    
    _bigIcon.image = [UIImage imageNamed:info.icons[0]];
    _rightTopIcon.image = [UIImage imageNamed:info.icons[1]];
    _rightBottomIcon.image = [UIImage imageNamed:info.icons[2]];
}

@end
