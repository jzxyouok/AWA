//
//  BDTableViewModel.m
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "BDTableViewModel.h"


#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "requires ARC support."
#endif

@implementation BDTableViewModel

- (id)initWithDelegate:(id<BDTableViewModelDelegate>)delegate {
    if ((self = [super init])) {
        self.delegate = delegate;
        [self resetCompiledData];
    }
    return self;
}

- (id)initWithListArray:(NSArray *)listArray delegate:(id<BDTableViewModelDelegate>)delegate {
    if ((self = [self initWithDelegate:delegate])) {
        [self compileDataWithListArray:listArray];
    }
    return self;
}

- (id)initWithSectionedArray:(NSArray *)sectionedArray delegate:(id<BDTableViewModelDelegate>)delegate {
    if ((self = [self initWithDelegate:delegate])) {
        [self compileDataWithSectionedArray:sectionedArray];
    }
    return self;
}

- (id)init {
    return [self initWithDelegate:nil];
}

#pragma mark - Public Methods

- (id)objectAtSection:(int)section row:(int)row {
    return [self objectAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath == nil) {
        return nil;
    }
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    id object = nil;
    
    NSParameterAssert(section < self.sections.count);
    if (section < self.sections.count) {
        NSArray *rows = [[self.sections objectAtIndex:section] rows];
        
        NSParameterAssert(row < rows.count);
        if (row < rows.count) {
            object = [rows objectAtIndex:row];
        }
    }
    
    return object;
}

- (NSIndexPath *)indexPathForObject:(id)object {
    if (object == nil) {
        return nil;
    }
    
    NSArray *sections = self.sections;
    for (NSUInteger sectionIndex = 0; sectionIndex < [sections count]; sectionIndex++) {
        NSArray* rows = [[sections objectAtIndex:sectionIndex] rows];
        for (NSUInteger rowIndex = 0; rowIndex < [rows count]; rowIndex++) {
            if ([object isEqual:[rows objectAtIndex:rowIndex]]) {
                return [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
            }
        }
    }
    
    return nil;
}

#pragma mark - 配置

- (void)resetCompiledData {
    self.sections = nil;
}

- (void)compileDataWithListArray:(NSArray *)listArray {
    [self resetCompiledData];
    
    if (nil != listArray) {
        BDTableViewModelSection* section = [BDTableViewModelSection section];
        section.rows = listArray;
        self.sections = [NSArray arrayWithObject:section];
    }
}

- (void)compileDataWithSectionedArray:(NSArray *)sectionedArray {
    [self resetCompiledData];
    
    NSMutableArray* sections = [NSMutableArray array];
    
    NSString* currentSectionHeaderTitle = nil;
    NSString* currentSectionFooterTitle = nil;
    NSMutableArray* currentSectionRows = nil;
    
    for (id object in sectionedArray) {
        BOOL isSection = [object isKindOfClass:[NSString class]];
        BOOL isSectionFooter = [object isKindOfClass:[BDTableViewModelFooter class]];
        
        NSString* nextSectionHeaderTitle = nil;
        
        if (isSection) {
            nextSectionHeaderTitle = object;
            
        } else if (isSectionFooter) {
            BDTableViewModelFooter* footer = object;
            currentSectionFooterTitle = footer.title;
            
        } else {
            if (nil == currentSectionRows) {
                currentSectionRows = [[NSMutableArray alloc] init];
            }
            [currentSectionRows addObject:object];
        }
        
        // 遇到 section footer 或 title 了
        if (nil != nextSectionHeaderTitle || nil != currentSectionFooterTitle) {
            if (nil != currentSectionHeaderTitle
                || nil != currentSectionFooterTitle
                || nil != currentSectionRows) {
                BDTableViewModelSection* section = [BDTableViewModelSection section];
                section.headerTitle = currentSectionHeaderTitle;
                section.footerTitle = currentSectionFooterTitle;
                section.rows = currentSectionRows;
                [sections addObject:section];
            }
            
            currentSectionRows = nil;
            currentSectionHeaderTitle = nextSectionHeaderTitle;
            currentSectionFooterTitle = nil;
        }
    }
    
    // 提交未添加的 sections.
    if ([currentSectionRows count] > 0 || nil != currentSectionHeaderTitle) {
        BDTableViewModelSection* section = [BDTableViewModelSection section];
        section.headerTitle = currentSectionHeaderTitle;
        section.footerTitle = currentSectionFooterTitle;
        section.rows = currentSectionRows;
        [sections addObject:section];
    }
    currentSectionRows = nil;
    
    // 更新info
    self.sections = sections;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSParameterAssert((section >= 0 && (NSUInteger)section < self.sections.count) || 0 == self.sections.count);
    if (section >= 0 && (NSUInteger)section < self.sections.count) {
        NSString *title = [[self.sections objectAtIndex:section] headerTitle];
        return title.length == 0 ? nil : title;
        
    } else {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSParameterAssert((section >= 0 && (NSUInteger)section < self.sections.count) || 0 == self.sections.count);
    if (section >= 0 && (NSUInteger)section < self.sections.count) {
        return [[self.sections objectAtIndex:section] footerTitle];
        
    } else {
        return nil;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // 静态模型，禁止编辑.
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSParameterAssert((NSUInteger)section < self.sections.count || 0 == self.sections.count);
    if ((NSUInteger)section < self.sections.count) {
        return [[[self.sections objectAtIndex:section] rows] count];
        
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self objectAtIndexPath:indexPath];
    
    UITableViewCell* cell = nil;
    
    if (nil != self.createCellBlock) {
        cell = self.createCellBlock(tableView, indexPath, object);
    }
    
    if (nil == cell) {
        cell = [self.delegate tableViewModel:self
                            cellForTableView:tableView
                                 atIndexPath:indexPath
                                  withObject:object];
    }
    
    return cell;
}


@end



@implementation BDTableViewModelFooter

+ (BDTableViewModelFooter *)footerWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}

- (id)initWithTitle:(NSString *)title {
    if ((self = [super init])) {
        self.title = title;
    }
    return self;
}

@end



@implementation BDTableViewModelSection

+ (id)section {
    return [[self alloc] init];
}

@end
