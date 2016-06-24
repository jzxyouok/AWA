//
//  NSObject_UnofficialProtocol.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 14-7-2.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (UnofficialProtocol)

// Cell
- (id)initWithDictionary:(NSDictionary *)dic;

@end



@interface UIView (UnofficialProtocol)

- (void)reloadInfo:(id)info;

@end

