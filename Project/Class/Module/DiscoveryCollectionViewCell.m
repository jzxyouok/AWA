//
//  DiscoveryCollectionViewCell.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/4.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "DiscoveryCollectionViewCell.h"

@implementation DiscoveryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)reloadInfo:(MusicInfo *)info {
    _icon.image = [UIImage imageNamed:info.icon];
}

@end

