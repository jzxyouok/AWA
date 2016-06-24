//
//  BDTableViewActions.m
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "BDTableViewActions.h"

#import "BDCellFactory.h"
#import "BDTableViewModel.h"
#import "BDActions+Subclassing.h"
#import "NSMutableSet+BDExtension.h"
#import <objc/runtime.h>

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "requires ARC support."
#endif

@interface BDTableViewActions()

@property (nonatomic, BD_STRONG) NSMutableSet* forwardDelegates;

@end



@implementation BDTableViewActions

- (id)initWithTarget:(id)target {
    if ((self = [super initWithTarget:target])) {
        _forwardDelegates = [NSMutableSet nonRetainingSet];
        _tableViewCellSelectionStyle = UITableViewCellSelectionStyleBlue;
        _cellAccessoryType = BDCellAccessoryAuto;
    }
    return self;
}

#pragma mark - Forward Invocations

- (BOOL)shouldForwardSelector:(SEL)selector {
    struct objc_method_description description;
    description = protocol_getMethodDescription(@protocol(UITableViewDelegate), selector, NO, YES);
    return (description.name != NULL && description.types != NULL);
}

- (BOOL)respondsToSelector:(SEL)selector {
    if ([super respondsToSelector:selector]) {
        return YES;
        
    } else if ([self shouldForwardSelector:selector]) {
        for (id delegate in self.forwardDelegates) {
            if ([delegate respondsToSelector:selector]) {
                return YES;
            }
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if (signature == nil) {
        for (id delegate in self.forwardDelegates) {
            if ([delegate respondsToSelector:selector]) {
                signature = [delegate methodSignatureForSelector:selector];
            }
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    BOOL didForward = NO;
    
    if ([self shouldForwardSelector:invocation.selector]) {
        for (id delegate in self.forwardDelegates) {
            if ([delegate respondsToSelector:invocation.selector]) {
                [invocation invokeWithTarget:delegate];
                didForward = YES;
                break;
            }
        }
    }
    
    if (!didForward) {
        [super forwardInvocation:invocation];
    }
}

- (id<UITableViewDelegate>)forwardingTo:(id<UITableViewDelegate>)forwardDelegate {
    [self.forwardDelegates addObject:forwardDelegate];
    return self;
}

- (void)removeForwarding:(id<UITableViewDelegate>)forwardDelegate {
    [self.forwardDelegates removeObject:forwardDelegate];
}

#pragma mark - Object State

- (UITableViewCellAccessoryType)accessoryTypeForObject:(id)object {
    switch (_cellAccessoryType) {
        case BDCellAccessoryNone:
            return UITableViewCellAccessoryNone;
            break;
        case BDCellAccessoryDisclosureIndicator:
            return UITableViewCellAccessoryDisclosureIndicator;
            break;
        case BDCellAccessoryAuto: {
            BDObjectActions *action = [self actionForObjectOrClassOfObject:object];
            // Detail disclosure indicator 优先级高于 regular disclosure indicator.
            if (nil != action.detailAction) {
                return UITableViewCellAccessoryDetailDisclosureButton;
                
            } else if (nil != action.navigateAction) {
                return  UITableViewCellAccessoryDisclosureIndicator;
                
            }
            return UITableViewCellAccessoryNone;
        }
        default:
            break;
    }
}

- (UITableViewCellSelectionStyle)selectionStyleForObject:(id)object {
    BDObjectActions* action = [self actionForObjectOrClassOfObject:object];
    if (action.navigateAction || action.tapAction
        || action.navigateSelector || action.tapSelector) {
        return self.tableViewCellSelectionStyle;
        
    }
    return UITableViewCellSelectionStyleNone;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert([tableView.dataSource isKindOfClass:[BDTableViewModel class]]);
    
    if ([tableView.dataSource isKindOfClass:[BDTableViewModel class]]) {
        BDTableViewModel* model = (BDTableViewModel *)tableView.dataSource;
        id object = [model objectAtIndexPath:indexPath];
        if ([self isObjectActionable:object]) {
            cell.accessoryType = [self accessoryTypeForObject:object];
            cell.selectionStyle = [self selectionStyleForObject:object];
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    // 沿响应链转发
    for (id<UITableViewDelegate> delegate in self.forwardDelegates) {
        if ([delegate respondsToSelector:_cmd]) {
            [delegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert([tableView.dataSource isKindOfClass:[BDTableViewModel class]]);
    if ([tableView.dataSource isKindOfClass:[BDTableViewModel class]]) {
        BDTableViewModel* model = (BDTableViewModel *)tableView.dataSource;
        id object = [model objectAtIndexPath:indexPath];
        
        if ([self isObjectActionable:object]) {
            BDObjectActions* action = [self actionForObjectOrClassOfObject:object];
            
            // 默认为点击后 取消选中
            BOOL shouldDeselect = YES;
            if (action.tapAction) {
                shouldDeselect = action.tapAction(object, self.target, indexPath);
            }
            if (action.tapSelector && [self.target respondsToSelector:action.tapSelector]) {
                NSMethodSignature *methodSignature = [self.target methodSignatureForSelector:action.tapSelector];
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
                invocation.selector = action.tapSelector;
                if (methodSignature.numberOfArguments >= 3) {
                    [invocation setArgument:&object atIndex:2];
                }
                if (methodSignature.numberOfArguments >= 4) {
                    [invocation setArgument:&indexPath atIndex:3];
                }
                [invocation invokeWithTarget:self.target];
                
                NSUInteger length = invocation.methodSignature.methodReturnLength;
                if (length > 0) {
                    char *buffer = (void *)malloc(length);
                    memset(buffer, 0, sizeof(char) * length);
                    [invocation getReturnValue:buffer];
                    for (NSUInteger index = 0; index < length; ++index) {
                        NSLog(@"test %s %lu  %d", buffer, (unsigned long)index, buffer[index]);
                        shouldDeselect = buffer[index];
                    }
                    free(buffer);
                }
            }
            if (shouldDeselect) {
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }
            
            if (action.navigateAction) {
                action.navigateAction(object, self.target, indexPath);
            }
            if (action.navigateSelector && [self.target respondsToSelector:action.navigateSelector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [self.target performSelector:action.navigateSelector withObject:object withObject:indexPath];
#pragma clang diagnostic pop
            }
        }
    }
    
    // 沿响应链转发
    for (id<UITableViewDelegate> delegate in self.forwardDelegates) {
        if ([delegate respondsToSelector:_cmd]) {
            [delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
        }
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert([tableView.dataSource isKindOfClass:[BDTableViewModel class]]);
    if ([tableView.dataSource isKindOfClass:[BDTableViewModel class]]) {
        BDTableViewModel* model = (BDTableViewModel *)tableView.dataSource;
        id object = [model objectAtIndexPath:indexPath];
        
        if ([self isObjectActionable:object]) {
            BDObjectActions* action = [self actionForObjectOrClassOfObject:object];
            
            if (action.detailAction) {
                action.detailAction(object, self.target, indexPath);
            }
            if (action.detailSelector && [self.target respondsToSelector:action.detailSelector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [self.target performSelector:action.detailSelector withObject:object withObject:indexPath];
#pragma clang diagnostic pop
            }
        }
    }
    
    // 沿响应链转发
    for (id<UITableViewDelegate> delegate in self.forwardDelegates) {
        if ([delegate respondsToSelector:_cmd]) {
            [delegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
        }
    }
}

@end
