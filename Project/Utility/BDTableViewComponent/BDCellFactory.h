//
//  BDCellFactory.h
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BDTableViewModel.h"

// 该工厂用于接收一个模型对象，创建并返回UITableViewCell对象
// 注：模型对象必须遵循BDCellObjectProtocol协议

@interface BDCellFactory : NSObject

+ (UITableViewCell *)tableViewModel:(BDTableViewModel *)tableViewModel
                   cellForTableView:(UITableView *)tableView
                        atIndexPath:(NSIndexPath *)indexPath
                         withObject:(id)object;

+ (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
               model:(BDTableViewModel *)model;

@end


@protocol BDCellModelProtocol <NSObject>
@required
// 该模型所要绑定的Cell的类
// 注：Cell类必须遵循 BDCellObject 协议
- (Class)cellClass;

@optional
// Cell的Style
- (UITableViewCellStyle)cellStyle;

@end


@protocol BDCellProtocol <NSObject>

@optional
// 当一个 cell 被创建或将复用时调用
- (BOOL)shouldUpdateCellWithObject:(id)object;

- (BOOL)shouldUpdateCellWithObject:(id)object indexPath:(NSIndexPath *)indexPath;

// 是否需要将模型的类名添加到ReuseIdentifier中
// 当cell 用于多种模型时，非常有用
+ (BOOL)shouldAppendObjectClassToReuseIdentifier;

// 计算cell 的高度
+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView;

@end



// 对BDCellObjectProtocol 进行简单的实现。具体的模型，可以继承该类，也可以重新写

@interface BDCellModel : NSObject <BDCellModelProtocol>

- (id)initWithCellClass:(Class)cellClass userInfo:(id)userInfo;
- (id)initWithCellClass:(Class)cellClass;

+ (id)objectWithCellClass:(Class)cellClass userInfo:(id)userInfo;
+ (id)objectWithCellClass:(Class)cellClass;

@property (nonatomic, readonly, BD_STRONG) id userInfo;

@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, BD_STRONG) UIColor *fontColor;

@end
