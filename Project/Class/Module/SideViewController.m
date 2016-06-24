//
//  SideViewController.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/2.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIViewController+MMDrawerController.h>
#import "SideViewController.h"
#import "SideTableViewCell.h"

#import "HomeViewController.h"

#define ATTRIBUTED_STRING(__X__)  [[NSMutableAttributedString alloc] initWithString:__X__]

@interface SideViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) BDTableViewActions *actions;
@property (nonatomic, strong) BDTableViewModel *model;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(4);
    
    [self reloadData];
}

- (void)reloadData {
    _actions = [[BDTableViewActions alloc] init];
    
    NSMutableArray *contents = [NSMutableArray array];
    
    [contents addObject:[SideInfo infoWithTitle:ATTRIBUTED_STRING(@"Search") icon:@"side_search"]];
    
    [contents addObject:[SideInfo infoWithTitle:ATTRIBUTED_STRING(@"Home") icon:@"side_home"]];
    
    [contents addObject:[SideInfo infoWithTitle:ATTRIBUTED_STRING(@"Favorites") icon:@"side_favorites"]];
    
    [contents addObject:[SideInfo infoWithTitle:ATTRIBUTED_STRING(@"My Page") icon:@"side_mypage"]];
    
    [contents addObject:[SideInfo infoWithTitle:ATTRIBUTED_STRING(@"Settings") icon:@"side_settings"]];
    
    _model = [[BDTableViewModel alloc] initWithSectionedArray:contents delegate:(id)[BDCellFactory class]];
    
    _tableView.dataSource = _model;
    
    [_tableView reloadData];
}

@end
