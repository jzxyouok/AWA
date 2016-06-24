//
//  BDMutableTableViewModel.h
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "BDTableViewModel.h"

@class BDMutableTableViewModel;

@protocol BDMutableTableViewModelDelegate <NSObject, BDTableViewModelDelegate>

@optional

- (BOOL)tableViewModel:(BDMutableTableViewModel *)tableViewModel
         canEditObject:(id)object
           atIndexPath:(NSIndexPath *)indexPath
           inTableView:(UITableView *)tableView;

- (BOOL)tableViewModel:(BDMutableTableViewModel *)tableViewModel
         canMoveObject:(id)object
           atIndexPath:(NSIndexPath *)indexPath
           inTableView:(UITableView *)tableView;

- (BOOL)tableViewModel:(BDMutableTableViewModel *)tableViewModel
      shouldMoveObject:(id)object
           atIndexPath:(NSIndexPath *)indexPath
           toIndexPath:(NSIndexPath *)toIndexPath
           inTableView:(UITableView *)tableView;

- (UITableViewRowAnimation)tableViewModel:(BDMutableTableViewModel *)tableViewModel
              deleteRowAnimationForObject:(id)object
                              atIndexPath:(NSIndexPath *)indexPath
                              inTableView:(UITableView *)tableView;

- (BOOL)tableViewModel:(BDMutableTableViewModel *)tableViewModel
    shouldDeleteObject:(id)object
           atIndexPath:(NSIndexPath *)indexPath
           inTableView:(UITableView *)tableView;

@end


@interface BDMutableTableViewModel : BDTableViewModel

@property (nonatomic, BD_WEAK) id<BDMutableTableViewModelDelegate> delegate;

- (NSArray *)addObject:(id)object;
- (NSArray *)addObject:(id)object toSection:(NSUInteger)section;
- (NSArray *)addObjectsFromArray:(NSArray *)array;
- (NSArray *)insertObject:(id)object atRow:(NSUInteger)row inSection:(NSUInteger)section;
- (NSArray *)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexSet *)addSectionWithTitle:(NSString *)title;
- (NSIndexSet *)insertSectionWithTitle:(NSString *)title atIndex:(NSUInteger)index;
- (NSIndexSet *)removeSectionAtIndex:(NSUInteger)index;

@end
