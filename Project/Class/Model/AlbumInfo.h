//
//  RecommandInfo.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/30.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumInfo : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *coverURL;

@property (nonatomic, assign) int favoriteCount;

@property (nonatomic, strong) NSArray *icons;
@property (nonatomic, strong) NSArray *musics;

@end
