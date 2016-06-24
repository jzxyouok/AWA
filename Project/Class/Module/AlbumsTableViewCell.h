//
//  AlbumsTableViewCell.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/3.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransformTableView.h"

@interface AlbumsTableViewCell : UITableViewCell<TransformCell>

@property (weak, nonatomic) IBOutlet UIView *scaleView;
@property (nonatomic, assign) float miniumScale;

@property (weak, nonatomic) IBOutlet UIView *iconContainer;

@property (weak, nonatomic) IBOutlet UIImageView *bigIcon;
@property (weak, nonatomic) IBOutlet UIImageView *rightTopIcon;
@property (weak, nonatomic) IBOutlet UIImageView *rightBottomIcon;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end
