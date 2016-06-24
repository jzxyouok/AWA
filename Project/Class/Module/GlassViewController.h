//
//  GlassViewController.h
//  BTGlassScrollViewExample
//
//  Created by Suteki(67111677@qq.com) on 15/9/25.
//  Copyright © 2015年 Byte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoViewController.h"
#import "BTGlassScrollView.h"

@interface GlassViewController : AutoViewController

@property (nonatomic, strong) BTGlassScrollView *glassScrollView;

- (void)configBackgroundImage:(UIImage *)backgroundImage foregroundScrollView:(UIScrollView *)foregroundScrollView;

@end
