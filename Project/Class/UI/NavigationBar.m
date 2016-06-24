//
//  NavigationBar.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/18.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar

+ (id)barWithWidth:(float)width {
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, width, NAV_BAR_HEIGHT)];
    
    return bar;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addBackground];
        [self addTitleLabel];
    }
    return self;
}

- (void)addLeftBtnWithImageName:(NSString *)imageName target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    _leftBtn = button;
}

- (void)addRightBtnWithImageName:(NSString *)imageName target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 44, 20, 44, 44)];
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    _rightBtn = button;
}

- (void)addRightBtnWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 115, 20, 100, 44)];
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:title forState:UIControlStateNormal];
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    _rightBtn = button;
}

- (void)addBackground {
    UIView *backgroundView = [UIView blurViewWithFrame:CGRectMake(0, 0, self.width, NAV_BAR_HEIGHT) style:BlurStyleDark];
    
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    backgroundView.userInteractionEnabled = NO;
    
    [self addSubview:backgroundView];
    
    _backgroundView = backgroundView;
}

- (void)addTitleLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, self.width - 80, 44)];
    label.textAlignment = NSTextAlignmentCenter;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    
    [self addSubview:label];
    
    _titleLabel = label;
}


@end
