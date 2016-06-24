//
//  BDRadioGroup.h
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BDCellFactory.h"

@protocol BDRadioGroupDelegate;
@class BDRadioGroupController;

@interface BDRadioGroup : NSObject <BDCellModelProtocol, UITableViewDelegate>

- (id)initWithController:(UIViewController *)controller;

@property (nonatomic, BD_WEAK) id<BDRadioGroupDelegate> delegate;

#pragma mark Mapping Objects

- (id)mapObject:(id)object toIdentifier:(NSInteger)identifier;

#pragma mark Selection

@property (nonatomic, assign) NSInteger selectedIdentifier;

- (BOOL)hasSelection;
- (void)clearSelection;

#pragma mark Object State

- (BOOL)isObjectInRadioGroup:(id)object;
- (BOOL)isObjectSelected:(id)object;
- (NSInteger)identifierForObject:(id)object;

#pragma mark Forwarding

@property (nonatomic, assign) UITableViewCellSelectionStyle tableViewCellSelectionStyle;

- (id<UITableViewDelegate>)forwardingTo:(id<UITableViewDelegate>)forwardDelegate;
- (void)removeForwarding:(id<UITableViewDelegate>)forwardDelegate;

#pragma mark Sub Radio Groups

@property (nonatomic, copy) NSString *cellTitle;
@property (nonatomic, copy) NSString *controllerTitle;

- (NSArray *)allObjects;

@end

@protocol BDRadioGroupDelegate <NSObject>
@required

- (void)radioGroup:(BDRadioGroup *)radioGroup didSelectIdentifier:(NSInteger)identifier;

@optional

- (NSString *)radioGroup:(BDRadioGroup *)radioGroup textForIdentifier:(NSInteger)identifier;

- (BOOL)radioGroup:(BDRadioGroup *)radioGroup radioGroupController:(BDRadioGroupController *)radioGroupController willAppear:(BOOL)animated;

@end

@interface BDRadioGroupCell : UITableViewCell <BDCellProtocol>

@end

