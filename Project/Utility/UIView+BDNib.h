//
//  UIView+BDNib.h
//  NdGameCenter
//
//  Created by Suteki(67111677@qq.com) on 10-12-01.
//  Copyright 2010 Baidu All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BDNib)

+ (id)loadFromNIB;
+ (id)loadFromNIBNamed:(NSString *)nibName;

@end
