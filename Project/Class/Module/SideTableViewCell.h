//
//  SideTableViewCell.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/4.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideInfo : NSObject<BDCellModelProtocol>

@property (nonatomic, copy) NSAttributedString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *imageURL;

+ (id)infoWithTitle:(NSAttributedString *)title icon:(NSString *)icon;

@end



@interface SideTableViewCell : UITableViewCell<BDCellProtocol>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;



@end
