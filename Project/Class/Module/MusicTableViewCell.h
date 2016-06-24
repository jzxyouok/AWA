//
//  MusicTableViewCell.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/5.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicTableViewCell : NormalTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;

@end
