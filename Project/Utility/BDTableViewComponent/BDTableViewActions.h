//
//  BDTableViewActions.h
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BDActions.h"

typedef enum {
    BDCellAccessoryNone,                //不管是否有绑定Action，均不显示Accessory
    BDCellAccessoryDisclosureIndicator, //不管是否有绑定Action，均显示DisclosureIndicator
    BDCellAccessoryAuto                 //根据Mode绑定的Action类型，自动显示相应的Accessory
}BDCellAccessoryType;

//  BDTableViewModel 和 BDTableViewActions 主要为了解决：table view的delegate和data source分离

@interface BDTableViewActions : BDActions <UITableViewDelegate>

@property (nonatomic, assign) BDCellAccessoryType cellAccessoryType;    // 默认是BDCellAccessoryAuto。

#pragma mark Forwarding

- (id<UITableViewDelegate>)forwardingTo:(id<UITableViewDelegate>)forwardDelegate;
- (void)removeForwarding:(id<UITableViewDelegate>)forwardDelegate;

#pragma mark Object state

- (UITableViewCellAccessoryType)accessoryTypeForObject:(id)object;
- (UITableViewCellSelectionStyle)selectionStyleForObject:(id)object;

#pragma mark Configurable Properties

@property (nonatomic, assign) UITableViewCellSelectionStyle tableViewCellSelectionStyle;

@end
