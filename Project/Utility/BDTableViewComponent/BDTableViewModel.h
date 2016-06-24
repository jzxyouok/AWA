//
//  BDTableViewModel.h
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef UITableViewCell* (^BDTableViewModelCellForIndexPathBlock)(UITableView* tableView, NSIndexPath* indexPath, id object);

@protocol BDTableViewModelDelegate;


@interface BDTableViewModel : NSObject <UITableViewDataSource>

#pragma mark Creating Table View Models

- (id)initWithDelegate:(id<BDTableViewModelDelegate>)delegate;
- (id)initWithListArray:(NSArray *)listArray delegate:(id<BDTableViewModelDelegate>)delegate;

// 数组中的每个NSString的实例，代表一个新的Section。
- (id)initWithSectionedArray:(NSArray *)sectionedArray delegate:(id<BDTableViewModelDelegate>)delegate;

#pragma mark Accessing Objects

- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
- (id)objectAtSection:(int)section row:(int)row;

// 该方法不适用于关键的代码路径（performance critical codepaths）
- (NSIndexPath *)indexPathForObject:(id)object;

#pragma mark Creating Table View Cells

@property (nonatomic, BD_WEAK) id<BDTableViewModelDelegate> delegate;

// 如果delegate和block同时存在, 将返回Block中创建的cell
@property (nonatomic, copy) BDTableViewModelCellForIndexPathBlock createCellBlock;

@property (nonatomic, BD_STRONG) NSArray* sections; // Array of BDTableViewModelSection

@end

// 该协议，用于获取rows，展示在Table View上。
@protocol BDTableViewModelDelegate <NSObject>

@required
// 从给出的index path从获取cell
- (UITableViewCell *)tableViewModel:(BDTableViewModel *)tableViewModel
                   cellForTableView:(UITableView *)tableView
                        atIndexPath:(NSIndexPath *)indexPath
                         withObject:(id)object;

@end


// 该对象用于表示section footer title

@interface BDTableViewModelFooter : NSObject

+ (id)footerWithTitle:(NSString *)title;
- (id)initWithTitle:(NSString *)title;

@property (nonatomic, copy) NSString* title;

@end



@interface BDTableViewModelSection : NSObject

+ (id)section;

@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;
@property (nonatomic, BD_STRONG) NSArray *rows;

@end

