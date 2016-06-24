//
//  BDFormCellCatalog.m
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "BDFormCellCatalog.h"
#import <objc/message.h>

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "requires ARC support."
#endif

static const CGFloat kSwitchLeftMargin = 10;
static const CGFloat kImageViewRightMargin = 10;
static const CGFloat kSegmentedControlMargin = 5;
static const CGFloat kDatePickerTextFieldRightMargin = 5;

UIEdgeInsets BDCellContentPadding(void) {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@implementation BDFormElement

+ (id)elementWithID:(NSInteger)elementID {
    BDFormElement* element = [[self alloc] init];
    element.elementID = elementID;
    
    element.fontSize = 14;
    element.fontColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
    
    return element;
}

- (Class)cellClass {
    // 子类必须实现该方法
    NSParameterAssert(NO);
    return nil;
}

@end


@implementation BDTextInputFormElement

+ (id)textInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<UITextFieldDelegate>)delegate {
    BDTextInputFormElement* element = [super elementWithID:elementID];
    element.placeholderText = placeholderText;
    element.value = value;
    element.delegate = delegate;
    return element;
}

+ (id)textInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value {
    return [self textInputElementWithID:elementID placeholderText:placeholderText value:value delegate:nil];
}

+ (id)passwordInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<UITextFieldDelegate>)delegate {
    BDTextInputFormElement* element = [self textInputElementWithID:elementID placeholderText:placeholderText value:value delegate:delegate];
    element.isPassword = YES;
    return element;
}

+ (id)passwordInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value {
    return [self passwordInputElementWithID:elementID placeholderText:placeholderText value:value delegate:nil];
}

- (Class)cellClass {
    return [BDTextInputFormElementCell class];
}

@end



@implementation BDSwitchFormElement

+ (id)switchElementWithID:(NSInteger)elementID labelText:(NSString *)labelText value:(BOOL)value didChangeTarget:(id)target didChangeSelector:(SEL)selector {
    BDSwitchFormElement* element = [super elementWithID:elementID];
    element.labelText = labelText;
    element.value = value;
    element.didChangeTarget = target;
    element.didChangeSelector = selector;
    return element;
}


+ (id)switchElementWithID:(NSInteger)elementID labelText:(NSString *)labelText value:(BOOL)value {
    return [self switchElementWithID:elementID labelText:labelText value:value didChangeTarget:nil didChangeSelector:nil];
}

- (Class)cellClass {
    return [BDSwitchFormElementCell class];
}

@end



@implementation BDSliderFormElement

+ (id)sliderElementWithID:(NSInteger)elementID labelText:(NSString *)labelText value:(float)value minimumValue:(float)minimumValue maximumValue:(float)maximumValue didChangeTarget:(id)target didChangeSelector:(SEL)selector {
    BDSliderFormElement* element = [super elementWithID:elementID];
    element.labelText = labelText;
    element.value = value;
    element.minimumValue = minimumValue;
    element.maximumValue = maximumValue;
    element.didChangeTarget = target;
    element.didChangeSelector = selector;
    return element;
}

+ (id)sliderElementWithID:(NSInteger)elementID labelText:(NSString *)labelText value:(float)value minimumValue:(float)minimumValue maximumValue:(float)maximumValue {
    return [self sliderElementWithID:elementID labelText:labelText value:value minimumValue:minimumValue maximumValue:maximumValue didChangeTarget:nil didChangeSelector:nil];
}

- (Class)cellClass {
    return [BDSliderFormElementCell class];
}

@end


@implementation BDSegmentedControlFormElement


+ (id)segmentedControlElementWithID:(NSInteger)elementID labelText:(NSString *)labelText segments:(NSArray *)segments selectedIndex:(NSInteger)selectedIndex didChangeTarget:(id)target didChangeSelector:(SEL)selector {
    BDSegmentedControlFormElement *element = [super elementWithID:elementID];
    element.labelText = labelText;
    element.selectedIndex = selectedIndex;
    element.segments = segments;
    element.didChangeTarget = target;
    element.didChangeSelector = selector;
    return element;
}

+ (id)segmentedControlElementWithID:(NSInteger)elementID labelText:(NSString *)labelText segments:(NSArray *)segments selectedIndex:(NSInteger)selectedIndex {
    return [self segmentedControlElementWithID:elementID labelText:labelText segments:segments selectedIndex:selectedIndex didChangeTarget:nil didChangeSelector:nil];
}

- (Class)cellClass {
    return [BDSegmentedControlFormElementCell class];
}

@end


@implementation BDDatePickerFormElement

+ (id)datePickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText date:(NSDate *)date datePickerMode:(UIDatePickerMode)datePickerMode didChangeTarget:(id)target didChangeSelector:(SEL)selector {
    BDDatePickerFormElement *element = [super elementWithID:elementID];
    element.labelText = labelText;
    element.date = date;
    element.datePickerMode = datePickerMode;
    element.didChangeTarget = target;
    element.didChangeSelector = selector;
    return element;
}

+ (id)datePickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText date:(NSDate *)date datePickerMode:(UIDatePickerMode)datePickerMode {
    return [self datePickerElementWithID:elementID labelText:labelText date:date datePickerMode:datePickerMode didChangeTarget:nil didChangeSelector:nil];
}

- (Class)cellClass {
    return [BDDatePickerFormElementCell class];
}

@end

#pragma mark -
#pragma mark Form Element Cells


@implementation BDFormElementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if ([self.textLabel respondsToSelector:@selector(minimumScaleFactor)]) {
            self.textLabel.minimumScaleFactor = 0.5;
        } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < NIIOS_6_0
            [self.textLabel setMinimumFontSize:10.0f];
#endif
        }
    }
    return self;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    _element = nil;
}


- (BOOL)shouldUpdateCellWithObject:(id)object {
    if (_element != object) {
        _element = object;
        
        self.tag = _element.elementID;
        
        self.textLabel.font = [UIFont systemFontOfSize:_element.fontSize];
        self.textLabel.textColor = _element.fontColor;
        
        return YES;
    }
    
    return NO;
}


@end


@implementation BDTextInputFormElementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _textField = [[UITextField alloc] init];
        [_textField setAdjustsFontSizeToFitWidth:YES];
        [_textField setMinimumFontSize:10.0f];
        [_textField addTarget:self action:@selector(textFieldDidChangeValue) forControlEvents:UIControlEventAllEditingEvents];
        [self.contentView addSubview:_textField];
        
        [self.textLabel removeFromSuperview];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textField.frame = UIEdgeInsetsInsetRect(self.contentView.bounds, BDCellContentPadding());
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    _textField.placeholder = nil;
    _textField.text = nil;
}


- (BOOL)shouldUpdateCellWithObject:(BDTextInputFormElement *)textInputElement {
    if ([super shouldUpdateCellWithObject:textInputElement]) {
        _textField.placeholder = textInputElement.placeholderText;
        _textField.text = textInputElement.value;
        _textField.delegate = textInputElement.delegate;
        _textField.secureTextEntry = textInputElement.isPassword;
        
        _textField.tag = self.tag;
        
        [self setNeedsLayout];
        return YES;
    }
    return NO;
}


- (void)textFieldDidChangeValue {
    BDTextInputFormElement* textInputElement = (BDTextInputFormElement *)self.element;
    textInputElement.value = _textField.text;
}

@end


@implementation BDSwitchFormElementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _switchControl = [[UISwitch alloc] init];
        [_switchControl addTarget:self action:@selector(switchDidChangeValue) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_switchControl];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIEdgeInsets contentPadding = BDCellContentPadding();
    CGRect contentFrame = UIEdgeInsetsInsetRect(self.contentView.frame, contentPadding);
    
    [_switchControl sizeToFit];
    CGRect frame = _switchControl.frame;
    frame.origin.y = floorf((self.contentView.frame.size.height - frame.size.height) / 2);
    frame.origin.x = self.contentView.frame.size.width - frame.size.width - frame.origin.y;
    _switchControl.frame = frame;
    
    frame = self.textLabel.frame;
    CGFloat leftEdge = 0;
    
    if (nil != self.imageView.image) {
        leftEdge = self.imageView.frame.size.width + kImageViewRightMargin;
    }
    frame.size.width = (self.contentView.frame.size.width
                        - contentFrame.origin.x
                        - _switchControl.frame.size.width
                        - _switchControl.frame.origin.y
                        - kSwitchLeftMargin
                        - leftEdge);
    self.textLabel.frame = frame;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.textLabel.text = nil;
}

- (BOOL)shouldUpdateCellWithObject:(BDSwitchFormElement *)switchElement {
    if ([super shouldUpdateCellWithObject:switchElement]) {
        _switchControl.on = switchElement.value;
        self.textLabel.text = switchElement.labelText;
        
        _switchControl.tag = self.tag;
        
        [self setNeedsLayout];
        return YES;
    }
    return NO;
}

- (void)switchDidChangeValue {
    BDSwitchFormElement* switchElement = (BDSwitchFormElement *)self.element;
    switchElement.value = _switchControl.on;
    
    if (nil != switchElement.didChangeSelector && nil != switchElement.didChangeTarget
        && [switchElement.didChangeTarget respondsToSelector:switchElement.didChangeSelector]) {
        
        // 下面这个会有内存警告
        //[switchElement.didChangeTarget performSelector: switchElement.didChangeSelector
        //                                    withObject: _switchControl];
        
        // 换一种解决方案
        objc_msgSend(switchElement.didChangeTarget,
                     switchElement.didChangeSelector, _switchControl);
    }
}

@end


@implementation BDSliderFormElementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _sliderControl = [[UISlider alloc] init];
        [_sliderControl addTarget:self action:@selector(sliderDidChangeValue) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_sliderControl];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIEdgeInsets contentPadding = BDCellContentPadding();
    CGRect contentFrame = UIEdgeInsetsInsetRect(self.contentView.frame, contentPadding);
    CGFloat labelWidth = contentFrame.size.width * 0.5f;
    
    CGRect frame = self.textLabel.frame;
    frame.size.width = labelWidth;
    self.textLabel.frame = frame;
    
    static const CGFloat kSliderLeftMargin = 8;
    [_sliderControl sizeToFit];
    frame = _sliderControl.frame;
    frame.origin.y = floorf((self.contentView.frame.size.height - frame.size.height) / 2);
    frame.origin.x = self.textLabel.frame.origin.x + self.textLabel.frame.size.width + kSliderLeftMargin;
    frame.size.width = contentFrame.size.width - frame.origin.x;
    _sliderControl.frame = frame;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.textLabel.text = nil;
}

- (BOOL)shouldUpdateCellWithObject:(BDSliderFormElement *)sliderElement {
    if ([super shouldUpdateCellWithObject:sliderElement]) {
        _sliderControl.minimumValue = sliderElement.minimumValue;
        _sliderControl.maximumValue = sliderElement.maximumValue;
        _sliderControl.value = sliderElement.value;
        self.textLabel.text = sliderElement.labelText;
        
        _sliderControl.tag = self.tag;
        
        [self setNeedsLayout];
        return YES;
    }
    return NO;
}


- (void)sliderDidChangeValue {
    BDSliderFormElement* sliderElement = (BDSliderFormElement *)self.element;
    sliderElement.value = _sliderControl.value;
    
    if (nil != sliderElement.didChangeSelector && nil != sliderElement.didChangeTarget
        && [sliderElement.didChangeTarget respondsToSelector:sliderElement.didChangeSelector]) {
        
        objc_msgSend(sliderElement.didChangeTarget,
                     sliderElement.didChangeSelector, _sliderControl);
    }
}

@end

@implementation BDSegmentedControlFormElementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _segmentedControl = [[UISegmentedControl alloc] init];
        [_segmentedControl addTarget:self action:@selector(selectedSegmentDidChangeValue) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:self.segmentedControl];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIEdgeInsets contentPadding = BDCellContentPadding();
    CGRect contentFrame = UIEdgeInsetsInsetRect(self.contentView.frame, contentPadding);
    
    [_segmentedControl sizeToFit];
    CGRect frame = _segmentedControl.frame;
    frame.size.height = self.contentView.frame.size.height - (2 * kSegmentedControlMargin);
    frame.origin.y = floorf((self.contentView.frame.size.height - frame.size.height) / 2);
    frame.origin.x = CGRectGetMaxX(contentFrame) - frame.size.width - kSegmentedControlMargin;
    _segmentedControl.frame = frame;
    
    frame = self.textLabel.frame;
    CGFloat leftEdge = 0;
    if (nil != self.imageView.image) {
        leftEdge = self.imageView.frame.size.width + kImageViewRightMargin;
    }
    frame.size.width = (self.contentView.frame.size.width
                        - contentFrame.origin.x
                        - _segmentedControl.frame.size.width
                        - kSegmentedControlMargin
                        - kSwitchLeftMargin
                        - leftEdge);
    self.textLabel.frame = frame;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.textLabel.text = nil;
    [self.segmentedControl removeAllSegments];
}


- (BOOL)shouldUpdateCellWithObject:(BDSegmentedControlFormElement *)segmentedControlElement {
    if ([super shouldUpdateCellWithObject:segmentedControlElement]) {
        self.textLabel.text = segmentedControlElement.labelText;
        [segmentedControlElement.segments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[NSString class]]) {
                [_segmentedControl insertSegmentWithTitle:obj atIndex:idx animated:NO];
                
            } else if ([obj isKindOfClass:[UIImage class]]) {
                [_segmentedControl insertSegmentWithImage:obj atIndex:idx animated:NO];
            }
        }];
        _segmentedControl.tag = self.tag;
        _segmentedControl.selectedSegmentIndex = segmentedControlElement.selectedIndex;
        
        [self setNeedsLayout];
        return YES;
    }
    return NO;
}

- (void)selectedSegmentDidChangeValue {
    BDSegmentedControlFormElement *segmentedControlElement = (BDSegmentedControlFormElement *)self.element;
    segmentedControlElement.selectedIndex = self.segmentedControl.selectedSegmentIndex;
    
    if (nil != segmentedControlElement.didChangeSelector && nil != segmentedControlElement.didChangeTarget
        && [segmentedControlElement.didChangeTarget respondsToSelector:segmentedControlElement.didChangeSelector]) {
        
        objc_msgSend(segmentedControlElement.didChangeTarget,
                     segmentedControlElement.didChangeSelector, _segmentedControl);
    }
}

@end


@interface BDDatePickerFormElementCell()

@property (nonatomic, readwrite, BD_STRONG) UITextField* dumbDateField;

@end


@implementation BDDatePickerFormElementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _datePicker = [[UIDatePicker alloc] init];
        [_datePicker addTarget:self
                        action:@selector(selectedDateDidChange)
              forControlEvents:UIControlEventValueChanged];
        
        _dateField = [[UITextField alloc] init];
        _dateField.delegate = self;
        _dateField.font = [UIFont systemFontOfSize:16.0f];
        _dateField.minimumFontSize = 10.0f;
        _dateField.backgroundColor = [UIColor clearColor];
        _dateField.adjustsFontSizeToFitWidth = YES;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < NIIOS_6_0
        _dateField.textAlignment = UITextAlignmentRight;
#else
        _dateField.textAlignment = NSTextAlignmentRight;
#endif
        _dateField.inputView = _datePicker;
        [self.contentView addSubview:_dateField];
        
        _dumbDateField = [[UITextField alloc] init];
        _dumbDateField.hidden = YES;
        _dumbDateField.enabled = NO;
        [self.contentView addSubview:_dumbDateField];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIEdgeInsets contentPadding = BDCellContentPadding();
    CGRect contentFrame = UIEdgeInsetsInsetRect(self.contentView.frame, contentPadding);
    
    [_dateField sizeToFit];
    CGRect frame = _dateField.frame;
    frame.origin.y = floorf((self.contentView.frame.size.height - frame.size.height) / 2);
    frame.origin.x = self.contentView.frame.size.width - frame.size.width - kDatePickerTextFieldRightMargin;
    _dateField.frame = frame;
    self.dumbDateField.frame = _dateField.frame;
    
    frame = self.textLabel.frame;
    CGFloat leftEdge = 0;
    
    if (nil != self.imageView.image) {
        leftEdge = self.imageView.frame.size.width + kImageViewRightMargin;
    }
    frame.size.width = (self.contentView.frame.size.width
                        - contentFrame.origin.x
                        - _dateField.frame.size.width
                        - _dateField.frame.origin.y
                        - leftEdge);
    self.textLabel.frame = frame;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.textLabel.text = nil;
    _dateField.text = nil;
}


- (BOOL)shouldUpdateCellWithObject:(BDDatePickerFormElement *)datePickerElement {
    if ([super shouldUpdateCellWithObject:datePickerElement]) {
        self.textLabel.text = datePickerElement.labelText;
        self.datePicker.datePickerMode = datePickerElement.datePickerMode;
        self.datePicker.date = datePickerElement.date;
        
        switch (self.datePicker.datePickerMode) {
            case UIDatePickerModeDate:
                self.dateField.text = [NSDateFormatter localizedStringFromDate:self.datePicker.date
                                                                     dateStyle:NSDateFormatterShortStyle
                                                                     timeStyle:NSDateFormatterNoStyle];
                break;
                
            case UIDatePickerModeTime:
                self.dateField.text = [NSDateFormatter localizedStringFromDate:self.datePicker.date
                                                                     dateStyle:NSDateFormatterNoStyle
                                                                     timeStyle:NSDateFormatterShortStyle];
                break;
                
            case UIDatePickerModeCountDownTimer:
                if (self.datePicker.countDownDuration == 0) {
                    self.dateField.text = NSLocalizedString(@"0 minutes", @"0 minutes");
                } else {
                    int hours = (int)(self.datePicker.countDownDuration / 3600);
                    int minutes = (int)((self.datePicker.countDownDuration - hours * 3600) / 60);
                    
                    self.dateField.text = [NSString stringWithFormat:
                                           NSLocalizedString(@"%d hours, %d min",
                                                             @"datepicker countdown hours and minutes"),
                                           hours,
                                           minutes];
                }
                break;
                
            case UIDatePickerModeDateAndTime:
            default:
                self.dateField.text = [NSDateFormatter localizedStringFromDate:self.datePicker.date
                                                                     dateStyle:NSDateFormatterShortStyle
                                                                     timeStyle:NSDateFormatterShortStyle];
                break;
        }
        
        self.dumbDateField.text = self.dateField.text;
        
        _dateField.tag = self.tag;
        
        _datePicker.date = datePickerElement.date;
        _datePicker.tag = self.tag;
        
        [self setNeedsLayout];
        return YES;
    }
    return NO;
}


- (void)selectedDateDidChange {
    switch (self.datePicker.datePickerMode) {
        case UIDatePickerModeDate:
            self.dateField.text = [NSDateFormatter localizedStringFromDate:_datePicker.date
                                                                 dateStyle:NSDateFormatterShortStyle
                                                                 timeStyle:NSDateFormatterNoStyle];
            break;
            
        case UIDatePickerModeTime:
            self.dateField.text = [NSDateFormatter localizedStringFromDate:_datePicker.date
                                                                 dateStyle:NSDateFormatterNoStyle
                                                                 timeStyle:NSDateFormatterShortStyle];
            break;
            
        case UIDatePickerModeCountDownTimer:
            if (self.datePicker.countDownDuration == 0) {
                self.dateField.text = NSLocalizedString(@"0 minutes", @"0 minutes");
            } else {
                int hours = (int)(self.datePicker.countDownDuration / 3600);
                int minutes = (int)((self.datePicker.countDownDuration - hours * 3600) / 60);
                
                self.dateField.text = [NSString stringWithFormat:
                                       NSLocalizedString(@"%d hours, %d min",
                                                         @"datepicker countdown hours and minutes"),
                                       hours,
                                       minutes];
            }
            break;
            
        case UIDatePickerModeDateAndTime:
        default:
            self.dateField.text = [NSDateFormatter localizedStringFromDate:_datePicker.date
                                                                 dateStyle:NSDateFormatterShortStyle
                                                                 timeStyle:NSDateFormatterShortStyle];
            break;
    }
    
    self.dumbDateField.text = self.dateField.text;
    
    BDDatePickerFormElement *datePickerElement = (BDDatePickerFormElement *)self.element;
    datePickerElement.date = _datePicker.date;
    
    if (nil != datePickerElement.didChangeSelector && nil != datePickerElement.didChangeTarget
        && [datePickerElement.didChangeTarget respondsToSelector:datePickerElement.didChangeSelector]) {
        
        objc_msgSend(datePickerElement.didChangeTarget,
                     datePickerElement.didChangeSelector, _datePicker);
        
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.dumbDateField.delegate = self.dateField.delegate;
    self.dumbDateField.font = self.dateField.font;
    self.dumbDateField.minimumFontSize = self.dateField.minimumFontSize;
    self.dumbDateField.backgroundColor = self.dateField.backgroundColor;
    self.dumbDateField.adjustsFontSizeToFitWidth = self.dateField.adjustsFontSizeToFitWidth;
    self.dumbDateField.textAlignment = self.dateField.textAlignment;
    self.dumbDateField.textColor = self.dateField.textColor;
    
    textField.hidden = YES;
    self.dumbDateField.hidden = NO;
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.hidden = NO;
    self.dumbDateField.hidden = YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return NO;
}

@end


@implementation BDTableViewModel (BDFormElementSearch)


- (id)elementWithID:(NSInteger)elementID {
    for (BDTableViewModelSection* section in self.sections) {
        for (BDFormElement* element in section.rows) {
            if (![element isKindOfClass:[BDFormElement class]]) {
                continue;
            }
            if (element.elementID == elementID) {
                return element;
            }
        }
    }
    return nil;
}


@end
