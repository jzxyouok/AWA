//
//  TrendingViewController.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/3.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "TrendingViewController.h"
#import "AlbumsTableViewCell.h"
#import "AlbumViewController.h"
#import "HomeViewController.h"
#import "TransformTableView.h"

#define PageKey @"trending"

@interface TrendingViewController()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet TransformTableView *tableView;
@property (nonatomic, strong) NSArray *dataList;

@end


@implementation TrendingViewController

- (id)init {
    if (self = [super init]) {
        self.title = @"TRENDING";
        self.itemTitle = @"TRENDING";
        self.itemSubtitle = @"Browse popular music.";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = _tableView;
 
    _tableView.tableHeaderView = self.headerView;
    
    [self configBackgroundImage:[UIImage imageNamed:@"background_0.jpg"]
           foregroundScrollView:_tableView];
    
    [self reloadData];
}

- (void)reloadData {
    self.dataList = [Mock mockAlbumList];
    
    [self.tableView reloadData];
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
    [HomeViewController sharedInstance].sharedView = cell.iconContainer;
    
    AlbumViewController *vc = [AlbumViewController spawn];
    AlbumInfo *info = _dataList[indexPath.row];
    vc.info = info;
    
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
