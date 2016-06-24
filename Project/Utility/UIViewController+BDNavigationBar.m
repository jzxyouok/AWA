//
//  UIViewController+BDNavigationBar.m
//  BDKit
//
//  Created by Suteki(67111677@qq.com) on 14-2-19.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "UIViewController+BDNavigationBar.h"

#define BUTTON_OFFSET (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) ? 16 : 6)
#define BUTTON_TITLE_FONT_SIZE 17

static UIColor *navigationButtonTitleColor = nil;

@implementation UIViewController (BDNavigationBar)

+ (void)setNavigationButtonTitleColor:(UIColor *)color {
    navigationButtonTitleColor = color;
}

+ (void)hideBackButtonTitle {
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
}

- (void)backToPreviousViewController {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)backBeforeViewController:(Class)aClass {
    if ([[self.navigationController.viewControllers firstObject] isKindOfClass:aClass]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        int index = -1;
        for (int i=0; i<self.navigationController.viewControllers.count; i++) {
            UIViewController *viewController = self.navigationController.viewControllers[i];
            if ([viewController isKindOfClass:aClass]) {
                index = i;
                break;
            }
            
            UIViewController *target = self.navigationController.viewControllers[index - 1];
            [self.navigationController popToViewController:target animated:YES];
        }
    }
}

- (UIButton *)setNavigationButtonWithImgName:(NSString *)imgName
                        highlightedImageName:(NSString *)highlightedImageName
                                      action:(SEL)action
                                      isLeft:(BOOL)isLeft
                             autoEdgeInserts:(BOOL)autoEdgeInserts {
    return [self setNavigationButtonWithImgName:imgName
                           highlightedImageName:highlightedImageName
                                          title:nil
                                         action:action
                                         isLeft:isLeft
                                autoEdgeInserts:autoEdgeInserts];
}

- (UIButton *)setNavigationButtonWithTitle:(NSString *)title
                                    action:(SEL)action
                                    isLeft:(BOOL)isLeft
                           autoEdgeInserts:(BOOL)autoEdgeInserts {
    return [self setNavigationButtonWithImgName:nil
                           highlightedImageName:nil
                                          title:title
                                         action:action
                                         isLeft:isLeft
                                autoEdgeInserts:autoEdgeInserts];
}

- (UIButton *)setNavigationButtonWithImgName:(NSString *)imgName
                        highlightedImageName:(NSString *)highlightedImageName
                                       title:(NSString *)title
                                      action:(SEL)action
                                      isLeft:(BOOL)isLeft
                             autoEdgeInserts:(BOOL)autoEdgeInserts {
    
    UIButton *btn = [[UIButton alloc] init];
    
    [self resetButton:btn img:imgName highlightImg:nil title:title];
    
    if (autoEdgeInserts) {
        int direction = isLeft ? 1 : -1;
        [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -direction * BUTTON_OFFSET, 0, direction * BUTTON_OFFSET)];
    }
    
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    }else {
        self.navigationItem.rightBarButtonItem = item;
    }
    return btn;
}

- (UIButton *)resetButton:(UIButton *)btn
                      img:(NSString *)imgStr
             highlightImg:(NSString *)highlightImgStr
                    title:(NSString *)title {
    UIImage *img = [UIImage imageNamed:imgStr];
    UIImage *highlightImg = [UIImage imageNamed:highlightImgStr];
    
    UIFont *titleFont = [UIFont systemFontOfSize:BUTTON_TITLE_FONT_SIZE];
    if (img) {
        btn.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    }else {
        btn.frame = CGRectMake(0, 0, [title sizeWithFont:titleFont].width + 20, 44);
    }
    btn.titleLabel.font = titleFont;
    [btn setTitle:title forState:UIControlStateNormal];
    if (navigationButtonTitleColor) {
        [btn setTitleColor:navigationButtonTitleColor forState:UIControlStateNormal];
    }
    
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:highlightImg forState:UIControlStateHighlighted];
    
    return btn;
}

@end
