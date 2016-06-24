//
//  BDCellFactory.m
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "BDCellFactory.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "requires ARC support."
#endif

@implementation BDCellFactory

+ (UITableViewCell *)cellWithClass:(Class)cellClass
                         tableView:(UITableView *)tableView
                            object:(id)object
                         indexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = nil;
    
    NSString *identifier = NSStringFromClass(cellClass);
    
    if ([cellClass respondsToSelector:@selector(shouldAppendObjectClassToReuseIdentifier)]
        && [cellClass shouldAppendObjectClassToReuseIdentifier]) {
        identifier = [identifier stringByAppendingFormat:@".%@", NSStringFromClass([object class])];
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (nil == cell) {
        UITableViewCellStyle style = UITableViewCellStyleDefault;
        if ([object respondsToSelector:@selector(cellStyle)]) {
            style = [object cellStyle];
        }
        @try {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(cellClass) owner:self options:nil];
            cell = (UITableViewCell *)[nibs firstObject];
        }@catch (NSException *exception) {
            // 如果没找到nib，会抛出NSInternalInconsistencyException。这时默认不处理。因为有可能压根没有ib。其他原因，则抛出异常，嘎嘎。
            if (![[exception name] isEqualToString:@"NSInternalInconsistencyException"]) {
                [exception raise];
            }
        }
        
        if (nil == cell) {
            cell = [[cellClass alloc] initWithStyle:style reuseIdentifier:identifier];
        }
    }
    
    if ([cell respondsToSelector:@selector(shouldUpdateCellWithObject:)]) {
        [(id<BDCellProtocol>)cell shouldUpdateCellWithObject:object];
    }
    
    if ([cell respondsToSelector:@selector(shouldUpdateCellWithObject:indexPath:)]) {
        [(id<BDCellProtocol>)cell shouldUpdateCellWithObject:object indexPath:indexPath];
    }
    
    return cell;
}

+ (UITableViewCell *)tableViewModel:(BDTableViewModel *)tableViewModel
                   cellForTableView:(UITableView *)tableView
                        atIndexPath:(NSIndexPath *)indexPath
                         withObject:(id)object {
    UITableViewCell* cell = nil;
    
    NSParameterAssert([object respondsToSelector:@selector(cellClass)]);
    
    if ([object respondsToSelector:@selector(cellClass)]) {
        Class cellClass = [object cellClass];
        cell = [self cellWithClass:cellClass tableView:tableView object:object indexPath:indexPath];
    }
    
    return cell;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath model:(BDTableViewModel *)model {
    CGFloat height = tableView.rowHeight;
    id object = [model objectAtIndexPath:indexPath];
    Class cellClass = nil;
    if ([object respondsToSelector:@selector(cellClass)]) {
        cellClass = [object cellClass];
    }
    if ([cellClass respondsToSelector:@selector(heightForObject:atIndexPath:tableView:)]) {
        CGFloat cellHeight = [cellClass heightForObject:object
                                            atIndexPath:indexPath tableView:tableView];
        if (cellHeight > 0) {
            height = cellHeight;
        }
    }
    return height;
}

@end



@interface BDCellModel()

@property (nonatomic, BD_WEAK) Class cellClass;
@property (nonatomic, BD_STRONG) id userInfo;

@end


@implementation BDCellModel

- (id)initWithCellClass:(Class)cellClass userInfo:(id)userInfo {
    if ((self = [super init])) {
        _cellClass = cellClass;
        _userInfo = userInfo;
        
        _fontColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
        _fontSize = 14;
    }
    return self;
}

- (id)initWithCellClass:(Class)cellClass {
    return [self initWithCellClass:cellClass userInfo:nil];
}

+ (id)objectWithCellClass:(Class)cellClass userInfo:(id)userInfo {
    return [[self alloc] initWithCellClass:cellClass userInfo:userInfo];
}

+ (id)objectWithCellClass:(Class)cellClass {
    return [[self alloc] initWithCellClass:cellClass userInfo:nil];
}

@end
