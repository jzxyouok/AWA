//
//  StyleInfo.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/30.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StyleInfo : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray *albumList;

@end
