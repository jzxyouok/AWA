//
//  TransformTableView.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/4.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "TransformTableView.h"

#define CONTENT_CENTER_OFFSET 60

@implementation TransformTableView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self transformCells];
}

- (void)transformCells {
    for (NSIndexPath *indexPath in self.indexPathsForVisibleRows) {
        UITableViewCell<TransformCell> *cell = [self cellForRowAtIndexPath:indexPath];
        if ([cell conformsToProtocol:@protocol(TransformCell)]) {
            CGFloat distanceFromCenter = [self computeDistanceFromCenter:indexPath];
            [cell transformCellForScale:[self computeScaleWithDistanceFromCenter:distanceFromCenter minScale:cell.miniumScale]];
        }
    }
}

- (CGFloat)computeDistanceFromCenter:(NSIndexPath *)indexPath {
    CGRect cellRect = [self rectForRowAtIndexPath:indexPath];
    float cellCenter = cellRect.origin.y + cellRect.size.height / 2;
    float contentCenter = self.contentOffset.y + self.bounds.size.height / 2 + CONTENT_CENTER_OFFSET;
    
    return fabs(cellCenter - contentCenter);
}

- (CGFloat)computeScaleWithDistanceFromCenter:(float)distanceFromCenter minScale:(float)minScale {
    return  (1.0 - minScale) * distanceFromCenter / self.bounds.size.height;
}


@end
