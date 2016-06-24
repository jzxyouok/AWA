//
//  DiscoveryCollectionViewCell.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/4.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoveryCollectionViewCell : UICollectionViewCell

//播放时，隐藏
@property (weak, nonatomic) IBOutlet UIView *markView;

//播放时，显示
@property (weak, nonatomic) IBOutlet UIImageView *playingIcon;

@property (weak, nonatomic) IBOutlet UIImageView *icon;


@property (nonatomic, strong) MusicInfo *musicInfo;

@end
