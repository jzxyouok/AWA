//
//  AlbumsListViewController.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/10.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "AlbumsListViewController.h"
#import "AlbumsTableViewCell.h"
#import "AlbumViewController.h"

@interface AlbumsListViewController ()

@property (weak, nonatomic) IBOutlet TransformTableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *banner;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) UIView *sharedView;

@end

@implementation AlbumsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLabel.text = self.title;
    
    [ASFSharedViewTransition addTransitionWithFromViewControllerClass:[AlbumsListViewController class]
                                                ToViewControllerClass:[AlbumViewController class]
                                             WithNavigationController:self.navigationController
                                                         WithDuration:0.3f];
    
    [self configBackgroundImage:[UIImage imageNamed:@"background_3.jpg"]
           foregroundScrollView:_tableView];
    
    [self reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _sharedView = nil;
}

- (void)reloadData {
    _banner.image = [UIImage imageNamed:_info.icon];
    _titleLabel.text = _info.name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    AlbumsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [AlbumsTableViewCell loadFromNIB];
    }
    
    AlbumInfo *info = _dataList[indexPath.row];
    [cell reloadInfo:info];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AlbumsTableViewCell *cell = [_tableView cellForRowAtIndexPath:[_tableView indexPathForSelectedRow]];
    _sharedView = cell.iconContainer;
    
    AlbumInfo *info = _dataList[indexPath.row];
  
    AlbumViewController *vc = [AlbumViewController spawn];
    vc.info = info;
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)sharedView {
    return _sharedView ? _sharedView : _banner;
}

- (ASFSharedViewTransitionStyle)transitionStyle {
    return ASFSharedViewTransitionStylePush;
}

@end
