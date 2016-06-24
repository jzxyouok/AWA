//
//  BDRadioGroupController.m
//  BDTableViewComponent
//
//  Created by Suteki(67111677@qq.com) on 14-3-17.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "BDRadioGroupController.h"

#import "BDCellFactory.h"
#import "BDRadioGroup.h"
#import "BDTableViewModel.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "requires ARC support."
#endif

@interface BDRadioGroupController ()
@property (nonatomic, readonly, BD_STRONG) BDRadioGroup* radioGroup;
@property (nonatomic, readonly, BD_STRONG) id<BDCellProtocol> tappedCell;
@property (nonatomic, readonly, BD_STRONG) BDTableViewModel* model;
@end





@implementation BDRadioGroupController

@synthesize radioGroup = _radioGroup;
@synthesize tappedCell = _tappedCell;
@synthesize model = _model;



- (void)dealloc {
  [_radioGroup removeForwarding:self];
}



- (id)initWithRadioGroup:(BDRadioGroup *)radioGroup tappedCell:(id<BDCellProtocol>)tappedCell {
  if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
    // A valid radio group must be provided.
    NSParameterAssert(nil != radioGroup);
    _radioGroup = radioGroup;
    _tappedCell = tappedCell;

    _model = [[BDTableViewModel alloc] initWithListArray:_radioGroup.allObjects
                                                delegate:(id)[BDCellFactory class]];
  }
  return self;
}



- (id)initWithStyle:(UITableViewStyle)style {
  // Use the initWithRadioGroup initializer.
  NSParameterAssert(NO);
  return [self initWithRadioGroup:nil tappedCell:nil];
}



- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.dataSource = self.model;
  self.tableView.delegate = [self.radioGroup forwardingTo:self.tableView.delegate];
}



#if __IPHONE_OS_VERSION_MIN_REQUIRED < NIIOS_6_0
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return NIIsSupportedOrientation(toInterfaceOrientation);
}
#endif



- (NSUInteger)supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskAllButUpsideDown;
}




#pragma mark - UITableViewDelegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tappedCell shouldUpdateCellWithObject:self.radioGroup];
}

@end
