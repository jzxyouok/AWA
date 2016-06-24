//
//  TransformTableView.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/4.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TransformCell <NSObject>

@property (nonatomic, assign) float miniumScale;

- (void)transformCellForScale:(float)scale;

@end


@interface TransformTableView : UITableView

@end
