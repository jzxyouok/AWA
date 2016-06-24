//
//  BDARCSingleton.h
//  BDKit
//
//  Created by Suteki(67111677@qq.com) on 14-11-11.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BD_ARC_SYNTHESIZE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)sharedInstance;


#define BD_ARC_SYNTHESIZE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)sharedInstance { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}