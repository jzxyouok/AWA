//
//  NavigationBar.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/18.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationBar : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

+ (id)barWithWidth:(float)width;

- (void)addLeftBtnWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

- (void)addRightBtnWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (void)addRightBtnWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

@end
