//
//  UIView+BDNib.m
//  NdGameCenter
//
//  Created by Suteki(67111677@qq.com) on 10-12-01.
//  Copyright 2010 Baidu All rights reserved.
//

#import "UIView+BDNib.h"

@implementation UIView (BDNib)

+ (NSString*)nibName {
    return [self description];
}

+ (id)loadFromNIB {
    NSString *nibName = [self nibName];
    return [self loadFromNIBNamed:nibName];
}

+ (id)loadFromNIBNamed:(NSString *)nibName {
    Class klass = [self class];
    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    for (id object in objects) {
        if ([object isKindOfClass:klass]) {
            return object;
        }
    }
    [NSException raise:@"WrongNibFormat" format:@"Nib for '%@' must contain one UIView, and its class must be '%@'", nibName, NSStringFromClass(klass)];
    return nil;
}

@end
