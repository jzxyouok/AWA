//
//  BDActions.m
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "BDActions.h"
#import "BDActions+Subclassing.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "requires ARC support."
#endif

@interface BDActions()

@property (nonatomic, BD_STRONG) NSMutableDictionary* objectMap;
@property (nonatomic, BD_STRONG) NSMutableSet* objectSet;
@property (nonatomic, BD_STRONG) NSMutableDictionary* classMap;

@end


@implementation BDActions

- (id)initWithTarget:(id)target {
    if ((self = [super init])) {
        _target = target;
        _objectMap = [[NSMutableDictionary alloc] init];
        _objectSet = [[NSMutableSet alloc] init];
        _classMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)init {
    return [self initWithTarget:nil];
}

#pragma mark - Private Methods

- (id)keyForObject:(id<NSObject>)object {
    return [NSNumber numberWithInteger:object.hash];
}


- (BDObjectActions *)actionForObject:(id<NSObject>)object {
    id key = [self keyForObject:object];
    BDObjectActions* action = [self.objectMap objectForKey:key];
    if (nil == action) {
        action = [[BDObjectActions alloc] init];
        [self.objectMap setObject:action forKey:key];
    }
    
    return action;
}

- (BDObjectActions *)actionForClass:(Class)class {
    BDObjectActions* action = [self.classMap objectForKey:class];
    if (nil == action) {
        action = [[BDObjectActions alloc] init];
        [self.classMap setObject:action forKey:(id<NSCopying>)class];
    }
    return action;
}

- (BDObjectActions *)actionForObjectOrClassOfObject:(id<NSObject>)object {
    id key = [self keyForObject:object];
    BDObjectActions* action = [self.objectMap objectForKey:key];
    if (nil == action) {
        action = [self.class objectFromKeyClass:object.class map:self.classMap];
    }
    return action;
}

#pragma mark - Public Methods

- (id)attachToObject:(id<NSObject>)object tapBlock:(BDActionBlock)action {
    [self.objectSet addObject:object];
    [self actionForObject:object].tapAction = action;
    return object;
}

- (id)attachToObject:(id<NSObject>)object detailBlock:(BDActionBlock)action {
    [self.objectSet addObject:object];
    [self actionForObject:object].detailAction = action;
    return object;
}

- (id)attachToObject:(id<NSObject>)object navigationBlock:(BDActionBlock)action {
    [self.objectSet addObject:object];
    [self actionForObject:object].navigateAction = action;
    return object;
}


- (id)attachToObject:(id<NSObject>)object tapSelector:(SEL)selector {
    [self.objectSet addObject:object];
    [self actionForObject:object].tapSelector = selector;
    return object;
}

- (id)attachToObject:(id<NSObject>)object detailSelector:(SEL)selector {
    [self.objectSet addObject:object];
    [self actionForObject:object].detailSelector = selector;
    return object;
}


- (id)attachToObject:(id<NSObject>)object navigationSelector:(SEL)selector {
    [self.objectSet addObject:object];
    [self actionForObject:object].navigateSelector = selector;
    return object;
}



- (void)attachToClass:(Class)aClass tapBlock:(BDActionBlock)action {
    [self actionForClass:aClass].tapAction = action;
}


- (void)attachToClass:(Class)aClass detailBlock:(BDActionBlock)action {
    [self actionForClass:aClass].detailAction = action;
}


- (void)attachToClass:(Class)aClass navigationBlock:(BDActionBlock)action {
    [self actionForClass:aClass].navigateAction = action;
}


- (void)attachToClass:(Class)aClass tapSelector:(SEL)selector {
    [self actionForClass:aClass].tapSelector = selector;
}

- (void)attachToClass:(Class)aClass detailSelector:(SEL)selector {
    [self actionForClass:aClass].detailSelector = selector;
}

- (void)attachToClass:(Class)aClass navigationSelector:(SEL)selector {
    [self actionForClass:aClass].navigateSelector = selector;
}

- (BOOL)isObjectActionable:(id<NSObject>)object {
    if (nil == object) {
        return NO;
    }
    
    BOOL objectIsActionable = [self.objectSet containsObject:object];
    if (!objectIsActionable) {
        objectIsActionable = (nil != [self.class objectFromKeyClass:object.class map:self.classMap]);
    }
    return objectIsActionable;
}

+ (id)objectFromKeyClass:(Class)keyClass map:(NSMutableDictionary *)map {
    id object = [map objectForKey:keyClass];
    
    if (nil == object) {
        Class superClass = nil;
        for (Class class in map.allKeys) {
            if ([keyClass isSubclassOfClass:class]
                && (nil == superClass || [keyClass isSubclassOfClass:superClass])) {
                superClass = class;
            }
        }
        
        if (nil != superClass) {
            object = [map objectForKey:superClass];
            
            [map setObject:object forKey:(id<NSCopying>)keyClass];
        }
    }
    
    if (nil == object) {
        [map setObject:[NSNull class] forKey:(id<NSCopying>)keyClass];
        
    } else if (object == [NSNull class]) {
        object = nil;
    }
    
    return object;
}

@end



@implementation BDObjectActions

@end


BDActionBlock BDPushControllerAction(Class controllerClass) {
    return ^(id object, id target, NSIndexPath* indexPath) {
        if ([target isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = target;
            
            if (controller.navigationController != nil) {
                UIViewController* controllerToPush = [[controllerClass alloc] init];
                [controller.navigationController pushViewController:controllerToPush
                                                           animated:YES];
            }
        }
       
        
        return NO;
    };
}
