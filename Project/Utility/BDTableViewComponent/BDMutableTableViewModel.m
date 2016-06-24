//
//  BDMutableTableViewModel.m
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "BDMutableTableViewModel.h"

#import "BDMutableTableViewModel+Private.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "requires ARC support."
#endif

@implementation BDMutableTableViewModel

#pragma mark - Public Methods

- (NSArray *)addObject:(id)object {
    BDTableViewModelSection* section = self.sections.count == 0 ? [self _appendSection] : self.sections.lastObject;
    [section.mutableRows addObject:object];
    return [NSArray arrayWithObject:[NSIndexPath indexPathForRow:section.mutableRows.count - 1
                                                       inSection:self.sections.count - 1]];
}

- (NSArray *)addObject:(id)object toSection:(NSUInteger)sectionIndex {
    NSParameterAssert(sectionIndex >= 0 && sectionIndex < self.sections.count);
    BDTableViewModelSection *section = [self.sections objectAtIndex:sectionIndex];
    [section.mutableRows addObject:object];
    return [NSArray arrayWithObject:[NSIndexPath indexPathForRow:section.mutableRows.count - 1
                                                       inSection:sectionIndex]];
}

- (NSArray *)addObjectsFromArray:(NSArray *)array {
    NSMutableArray* indices = [NSMutableArray array];
    for (id object in array) {
        [indices addObject:[[self addObject:object] objectAtIndex:0]];
    }
    return indices;
}

- (NSArray *)insertObject:(id)object atRow:(NSUInteger)row inSection:(NSUInteger)sectionIndex {
    NSParameterAssert(sectionIndex >= 0 && sectionIndex < self.sections.count);
    BDTableViewModelSection *section = [self.sections objectAtIndex:sectionIndex];
    [section.mutableRows insertObject:object atIndex:row];
    return [NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:sectionIndex]];
}

- (NSArray *)removeObjectAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(indexPath.section < (NSInteger)self.sections.count);
    if (indexPath.section >= (NSInteger)self.sections.count) {
        return nil;
    }
    BDTableViewModelSection* section = [self.sections objectAtIndex:indexPath.section];
    NSParameterAssert(indexPath.row < (NSInteger)section.mutableRows.count);
    if (indexPath.row >= (NSInteger)section.mutableRows.count) {
        return nil;
    }
    [section.mutableRows removeObjectAtIndex:indexPath.row];
    return [NSArray arrayWithObject:indexPath];
}

- (NSIndexSet *)addSectionWithTitle:(NSString *)title {
    BDTableViewModelSection* section = [self _appendSection];
    section.headerTitle = title;
    return [NSIndexSet indexSetWithIndex:self.sections.count - 1];
}

- (NSIndexSet *)insertSectionWithTitle:(NSString *)title atIndex:(NSUInteger)index {
    BDTableViewModelSection* section = [self _insertSectionAtIndex:index];
    section.headerTitle = title;
    return [NSIndexSet indexSetWithIndex:index];
}

- (NSIndexSet *)removeSectionAtIndex:(NSUInteger)index {
    NSParameterAssert(index >= 0 && index < self.sections.count);
    [self.sections removeObjectAtIndex:index];
    return [NSIndexSet indexSetWithIndex:index];
}



#pragma mark - Private Methods

- (BDTableViewModelSection *)_appendSection {
    if (nil == self.sections) {
        self.sections = [NSMutableArray array];
    }
    BDTableViewModelSection* section = nil;
    section = [[BDTableViewModelSection alloc] init];
    section.rows = [NSMutableArray array];
    [self.sections addObject:section];
    return section;
}

- (BDTableViewModelSection *)_insertSectionAtIndex:(NSUInteger)index {
    if (nil == self.sections) {
        self.sections = [NSMutableArray array];
    }
    BDTableViewModelSection* section = nil;
    section = [[BDTableViewModelSection alloc] init];
    section.rows = [NSMutableArray array];
    NSParameterAssert(index >= 0 && index <= self.sections.count);
    [self.sections insertObject:section atIndex:index];
    return section;
}

#pragma mark - UITableViewDataSource


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableViewModel:canEditObject:atIndexPath:inTableView:)]) {
        id object = [self objectAtIndexPath:indexPath];
        return [self.delegate tableViewModel:self canEditObject:object atIndexPath:indexPath inTableView:tableView];
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self objectAtIndexPath:indexPath];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BOOL shouldDelete = YES;
        if ([self.delegate respondsToSelector:@selector(tableViewModel:shouldDeleteObject:atIndexPath:inTableView:)]) {
            shouldDelete = [self.delegate tableViewModel:self shouldDeleteObject:object atIndexPath:indexPath inTableView:tableView];
        }
        if (shouldDelete) {
            NSArray *indexPaths = [self removeObjectAtIndexPath:indexPath];
            UITableViewRowAnimation animation = UITableViewRowAnimationAutomatic;
            if ([self.delegate respondsToSelector:@selector(tableViewModel:deleteRowAnimationForObject:atIndexPath:inTableView:)]) {
                animation = [self.delegate tableViewModel:self deleteRowAnimationForObject:object atIndexPath:indexPath inTableView:tableView];
            }
            [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableViewModel:canMoveObject:atIndexPath:inTableView:)]) {
        id object = [self objectAtIndexPath:indexPath];
        return [self.delegate tableViewModel:self canMoveObject:object atIndexPath:indexPath inTableView:tableView];
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    id object = [self objectAtIndexPath:sourceIndexPath];
    BOOL shouldMove = YES;
    if ([self.delegate respondsToSelector:@selector(tableViewModel:shouldMoveObject:atIndexPath:toIndexPath:inTableView:)]) {
        shouldMove = [self.delegate tableViewModel:self shouldMoveObject:object atIndexPath:sourceIndexPath toIndexPath:destinationIndexPath inTableView:tableView];
    }
    if (shouldMove) {
        [self removeObjectAtIndexPath:sourceIndexPath];
        [self insertObject:object atRow:destinationIndexPath.row inSection:destinationIndexPath.section];
    }
}

@end


@implementation BDTableViewModelSection (Mutable)


- (NSMutableArray *)mutableRows {
    NSParameterAssert([self.rows isKindOfClass:[NSMutableArray class]] || nil == self.rows);
    
    self.rows = nil == self.rows ? [NSMutableArray array] : self.rows;
    return (NSMutableArray *)self.rows;
}

@end
