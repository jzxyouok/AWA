//
//  BDActions.h
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^BDActionBlock)(id object, id target, NSIndexPath* indexPath);

@interface BDActions : NSObject

- (id)initWithTarget:(id)target;

#pragma mark - Mapping Objects

- (id)attachToObject:(id)object tapBlock:(BDActionBlock)action;
- (id)attachToObject:(id)object navigationBlock:(BDActionBlock)action;

- (id)attachToObject:(id<NSObject>)object tapSelector:(SEL)selector;
- (id)attachToObject:(id<NSObject>)object navigationSelector:(SEL)selector;


#pragma mark - Mapping Classes

- (void)attachToClass:(Class)aClass tapBlock:(BDActionBlock)action;
- (void)attachToClass:(Class)aClass navigationBlock:(BDActionBlock)action;

- (void)attachToClass:(Class)aClass tapSelector:(SEL)selector;
- (void)attachToClass:(Class)aClass navigationSelector:(SEL)selector;


#pragma mark - Discarded

//- (id)attachToObject:(id)object detailBlock:(BDActionBlock)action;
//- (id)attachToObject:(id<NSObject>)object detailSelector:(SEL)selector;
//- (void)attachToClass:(Class)aClass detailBlock:(BDActionBlock)action;
//- (void)attachToClass:(Class)aClass detailSelector:(SEL)selector;

#pragma mark - Object State

- (BOOL)isObjectActionable:(id)object;

+ (id)objectFromKeyClass:(Class)keyClass map:(NSMutableDictionary *)map;

@end


BDActionBlock BDPushControllerAction(Class controllerClass);
