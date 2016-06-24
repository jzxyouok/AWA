//
//  BDFormCellCatalog.h
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "BDCellFactory.h"

#pragma mark - Form Elements

@interface BDFormElement : NSObject <BDCellModelProtocol>

+ (id)elementWithID:(NSInteger)elementID;

@property (nonatomic, assign) NSInteger elementID;

@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, BD_STRONG) UIColor *fontColor;

@end

@interface BDTextInputFormElement : BDFormElement

+ (id)textInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<UITextFieldDelegate>)delegate;
+ (id)textInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value;

+ (id)passwordInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<UITextFieldDelegate>)delegate;
+ (id)passwordInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value;

@property (nonatomic, copy) NSString* placeholderText;
@property (nonatomic, copy) NSString* value;
@property (nonatomic, assign) BOOL isPassword;
@property (nonatomic, BD_WEAK) id<UITextFieldDelegate> delegate;

@end

@interface BDSwitchFormElement : BDFormElement

+ (id)switchElementWithID:(NSInteger)elementID labelText:(NSString *)labelText value:(BOOL)value didChangeTarget:(id)target didChangeSelector:(SEL)selector;
+ (id)switchElementWithID:(NSInteger)elementID labelText:(NSString *)labelText value:(BOOL)value;

@property (nonatomic, copy) NSString* labelText;
@property (nonatomic, assign) BOOL value;
@property (nonatomic, BD_WEAK) id didChangeTarget;
@property (nonatomic, assign) SEL didChangeSelector;

@end

@interface BDSliderFormElement : BDFormElement

+ (id)sliderElementWithID:(NSInteger)elementID labelText:(NSString *)labelText value:(float)value minimumValue:(float)minimumValue maximumValue:(float)maximumValue didChangeTarget:(id)target didChangeSelector:(SEL)selector;
+ (id)sliderElementWithID:(NSInteger)elementID labelText:(NSString *)labelText value:(float)value minimumValue:(float)minimumValue maximumValue:(float)maximumValue;

@property (nonatomic, copy) NSString* labelText;
@property (nonatomic, assign) float value;
@property (nonatomic, assign) float minimumValue;
@property (nonatomic, assign) float maximumValue;
@property (nonatomic, BD_WEAK) id didChangeTarget;
@property (nonatomic, assign) SEL didChangeSelector;

@end


@interface BDSegmentedControlFormElement : BDFormElement

+ (id)segmentedControlElementWithID:(NSInteger)elementID labelText:(NSString *)labelText segments:(NSArray *)segments selectedIndex:(NSInteger)selectedIndex didChangeTarget:(id)target didChangeSelector:(SEL)selector ;

+ (id)segmentedControlElementWithID:(NSInteger)elementID labelText:(NSString *)labelText segments:(NSArray *)segments selectedIndex:(NSInteger)selectedIndex;

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, BD_STRONG) NSArray *segments;
@property (nonatomic, BD_WEAK) id didChangeTarget;
@property (nonatomic, assign) SEL didChangeSelector;

@end

@interface BDDatePickerFormElement : BDFormElement

+ (id)datePickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText date:(NSDate *)date datePickerMode:(UIDatePickerMode)datePickerMode didChangeTarget:(id)target didChangeSelector:(SEL)selector;

+ (id)datePickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText date:(NSDate *)date datePickerMode:(UIDatePickerMode)datePickerMode;

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, BD_STRONG) NSDate *date;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, BD_WEAK) id didChangeTarget;
@property (nonatomic, assign) SEL didChangeSelector;

@end


#pragma mark - Form Element Cells


@interface BDFormElementCell : UITableViewCell <BDCellProtocol>

@property (nonatomic, readonly, BD_STRONG) BDFormElement* element;

@end


@interface BDTextInputFormElementCell : BDFormElementCell <UITextFieldDelegate>

@property (nonatomic, readonly, BD_STRONG) UITextField* textField;

@end


@interface BDSwitchFormElementCell : BDFormElementCell <UITextFieldDelegate>

@property (nonatomic, readonly, BD_STRONG) UISwitch* switchControl;

@end


@interface BDSliderFormElementCell : BDFormElementCell <UITextFieldDelegate>

@property (nonatomic, readonly, BD_STRONG) UISlider* sliderControl;

@end


@interface BDSegmentedControlFormElementCell : BDFormElementCell

@property (nonatomic, readonly, BD_STRONG) UISegmentedControl *segmentedControl;

@end


@interface BDDatePickerFormElementCell : BDFormElementCell <UITextFieldDelegate>

@property (nonatomic, readonly, BD_STRONG) UITextField *dateField;
@property (nonatomic, readonly, BD_STRONG) UIDatePicker *datePicker;

@end


@interface BDTableViewModel (BDFormElementSearch)

- (id)elementWithID:(NSInteger)elementID;

@end
