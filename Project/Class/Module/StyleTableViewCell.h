//
//  MoodTableViewCell.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/4.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StyleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *parallaxImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
