//
//  BDActions+Subclassing.h
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "BDActions.h"

@interface BDObjectActions : NSObject

@property (nonatomic, copy) BDActionBlock tapAction;
@property (nonatomic, copy) BDActionBlock detailAction;
@property (nonatomic, copy) BDActionBlock navigateAction;

@property (nonatomic, assign) SEL tapSelector;
@property (nonatomic, assign) SEL detailSelector;
@property (nonatomic, assign) SEL navigateSelector;

@end

@interface BDActions ()

@property (nonatomic, BD_WEAK) id target;

- (BDObjectActions *)actionForObjectOrClassOfObject:(id<NSObject>)object;

@end
