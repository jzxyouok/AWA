//
//
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "BDMutableTableViewModel.h"

@interface BDMutableTableViewModel (Private)

@property (nonatomic, BD_STRONG) NSMutableArray *sections; // Array of BDTableViewModelSection
@property (nonatomic, BD_STRONG) NSMutableArray *sectionIndexTitles;
@property (nonatomic, BD_STRONG) NSMutableDictionary *sectionPrefixToSectionIndex;

@end

@interface BDTableViewModelSection (Mutable)

- (NSMutableArray *)mutableRows;

@end
