//
//  AutoViewController.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/9/28.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "BaseViewController.h"

@interface AutoViewController : BaseViewController<UIScrollViewDelegate>

@property (nonatomic, assign) BOOL needNavigationBarAnimation; // default is YES

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end
