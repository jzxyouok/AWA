//
//  NSObject+BDLifeCycle.m
//  BDKit
//
//  Created by Suteki(67111677@qq.com) on 14-2-24.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "NSObject+BDLifeCycle.h"

@implementation NSObject (BDLifeCycle)

+ (id)spawn {
	return [[self alloc] init];
}

@end
