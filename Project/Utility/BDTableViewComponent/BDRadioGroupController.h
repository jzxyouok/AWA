//
//  BDRadioGroupController.h
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDRadioGroup;
@protocol BDCellProtocol;

@interface BDRadioGroupController : UITableViewController


- (id)initWithRadioGroup:(BDRadioGroup *)radioGroup tappedCell:(id<BDCellProtocol>)tappedCell;

@end
