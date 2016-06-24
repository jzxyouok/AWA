//
//  HomeItemViewController.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/3.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "HomeItemViewController.h"

@interface HomeItemViewController()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;

@end



@implementation HomeItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerView = [self createHeaderView];
    
    _titleLabel = [self createTitleLabel];
    [_headerView addSubview:_titleLabel];
    
    _subtitleLabel = [self createSubtitleLabel];
    [_headerView addSubview:_subtitleLabel];
    
    _titleLabel.text = _itemTitle;
    _subtitleLabel.text = _itemSubtitle;
}

- (UIView *)createHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 220)];
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    return headerView;
}

- (UILabel *)createTitleLabel {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 12 + NAV_BAR_HEIGHT, 300, 20)];
    titleLabel.textColor = COLOR(8);
    titleLabel.font = [UIFont systemFontOfSize:24];
    
    return titleLabel;
}

- (UILabel *)createSubtitleLabel {
    UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 45 + NAV_BAR_HEIGHT, 300, 20)];
    subtitleLabel.textColor = COLOR(8);
    subtitleLabel.font = [UIFont systemFontOfSize:15];
    
    return subtitleLabel;
}

@end
