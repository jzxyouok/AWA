//
//  BDCellCatalog.m
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "BDCellCatalog.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "requires ARC support."
#endif

@implementation BDTitleCellObject

- (id)initWithCellClass:(Class)cellClass userInfo:(id)userInfo {
    return [super initWithCellClass:cellClass userInfo:userInfo];
}

- (id)initWithTitle:(NSString *)title image:(UIImage *)image {
    if ((self = [self initWithCellClass:[BDTextCell class] userInfo:nil])) {
        _title = [title copy];
        _image = image;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title {
    return [self initWithTitle:title image:nil];
}

- (id)init {
    return [self initWithTitle:nil image:nil];
}

+ (id)objectWithTitle:(NSString *)title image:(UIImage *)image {
    return [[self alloc] initWithTitle:title image:image];
}


+ (id)objectWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title image:nil];
}

@end


@implementation BDSubtitleCellObject

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(UIImage *)image {
    if ((self = [super initWithTitle:title image:image])) {
        _subtitle = [subtitle copy];
        _cellStyle = UITableViewCellStyleSubtitle;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    return [self initWithTitle:title subtitle:subtitle image:nil];
}

- (id)initWithTitle:(NSString *)title image:(UIImage *)image {
    return [self initWithTitle:title subtitle:nil image:image];
}

+ (id)objectWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(UIImage *)image {
    return [[self alloc] initWithTitle:title subtitle:subtitle image:image];
}

+ (id)objectWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    return [[self alloc] initWithTitle:title subtitle:subtitle image:nil];
}

@end


@implementation BDTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.imageView.image = nil;
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
}

- (BOOL)shouldUpdateCellWithObject:(id)object {
    if ([object isKindOfClass:[BDTitleCellObject class]]) {
        BDTitleCellObject* titleObject = object;
        self.textLabel.text = titleObject.title;
        self.imageView.image = titleObject.image;
        
        self.textLabel.font = [UIFont systemFontOfSize:titleObject.fontSize];
        self.textLabel.textColor = titleObject.fontColor;
    }
    if ([object isKindOfClass:[BDSubtitleCellObject class]]) {
        BDSubtitleCellObject* subtitleObject = object;
        self.detailTextLabel.text = subtitleObject.subtitle;
        
        self.textLabel.font = [UIFont systemFontOfSize:subtitleObject.fontSize];
        self.textLabel.textColor = subtitleObject.fontColor;
    }
    
    return YES;
}

@end
