//
//  MoodViewController.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/4.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "StyleViewController.h"
#import "StyleTableViewCell.h"
#import "AlbumsListViewController.h"
#import "HomeViewController.h"

@interface StyleViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation StyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = _tableView;
    
    _tableView.tableHeaderView = self.headerView;
    
    [self configBackgroundImage:[UIImage imageNamed:_backgroundName]
           foregroundScrollView:_tableView];
    
    [self reloadData];
}

- (void)viewDidShow {
    [super viewDidShow];
    [self scrollViewDidScroll:_tableView];
}

- (void)reloadData {
    self.dataList = [Mock mockStyleList];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    StyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [StyleTableViewCell loadFromNIB];
    }
    
    [cell reloadInfo:_dataList[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    StyleTableViewCell *cell = [_tableView cellForRowAtIndexPath:[_tableView indexPathForSelectedRow]];
    [HomeViewController sharedInstance].sharedView = cell.parallaxImage;
    
    StyleInfo *info = _dataList[indexPath.row];
    
    AlbumsListViewController *vc = [AlbumsListViewController spawn];
    vc.dataList = info.albumList;
    vc.info = info;
    
    vc.title = info.name;
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    NSArray *visibleCells = [self.tableView visibleCells];
    
    for (StyleTableViewCell *cell in visibleCells) {
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
    }
}

@end
