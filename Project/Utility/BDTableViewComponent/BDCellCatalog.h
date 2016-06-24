//
//  BDCellCatalog.h
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "BDCellFactory.h"


@interface BDTitleCellObject : BDCellModel

- (id)initWithTitle:(NSString *)title
              image:(UIImage *)image;

- (id)initWithTitle:(NSString *)title;

+ (id)objectWithTitle:(NSString *)title
                image:(UIImage *)image;

+ (id)objectWithTitle:(NSString *)title;

@property (nonatomic, copy) NSString* title;
@property (nonatomic, BD_STRONG) UIImage* image;

@end


@interface BDSubtitleCellObject : BDTitleCellObject

@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, assign) UITableViewCellStyle cellStyle;

- (id)initWithTitle:(NSString *)title
           subtitle:(NSString *)subtitle
              image:(UIImage *)image;

+ (id)objectWithTitle:(NSString *)title
             subtitle:(NSString *)subtitle
                image:(UIImage *)image;

- (id)initWithTitle:(NSString *)title
           subtitle:(NSString *)subtitle;

+ (id)objectWithTitle:(NSString *)title
             subtitle:(NSString *)subtitle;

@end


@interface BDTextCell : UITableViewCell <BDCellProtocol>

@end
