//
//  NSMutableSet+BDExtension.m
//  BDKit
//
//  Created by Suteki(67111677@qq.com) on 14-3-14.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "NSMutableSet+BDExtension.h"

// No-ops for non-retaining objects.
static const void *	__TTRetainNoOp(CFAllocatorRef allocator, const void * value) { return value; }
static void			__TTReleaseNoOp(CFAllocatorRef allocator, const void * value) { }

@implementation NSMutableSet (BDExtension)

+ (NSMutableSet *)nonRetainingSet {
    CFSetCallBacks callbacks = kCFTypeSetCallBacks;
    callbacks.retain = __TTRetainNoOp;
    callbacks.release = __TTReleaseNoOp;
    return (NSMutableSet *)CFBridgingRelease(CFSetCreateMutable(nil, 0, &callbacks));
}

@end
