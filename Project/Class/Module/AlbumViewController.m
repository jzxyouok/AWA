//
//  AlbumViewController.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/5.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "AlbumViewController.h"
#import "MusicTableViewCell.h"

@interface AlbumViewController ()<ASFSharedViewTransitionDataSource, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *iconContainer;
@property (weak, nonatomic) IBOutlet UIImageView *bigIcon;
@property (weak, nonatomic) IBOutlet UIImageView *rightTopIcon;
@property (weak, nonatomic) IBOutlet UIImageView *rightBottomIcon;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *header;



@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.needNavigationBarAnimation = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self reloadData];
}

- (void)reloadData {
    [_tableView reloadData];
    
    self.title = _info.name;
    
    _bigIcon.image = [UIImage imageNamed:_info.icons[0]];
    _rightTopIcon.image = [UIImage imageNamed:_info.icons[1]];
    _rightBottomIcon.image = [UIImage imageNamed:_info.icons[2]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _info.musics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    MusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [MusicTableViewCell loadFromNIB];
    }
    MusicInfo *info = _info.musics[indexPath.row];
    
    [cell reloadInfo:info];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)sharedView {
    return _iconContainer;
}

@end
