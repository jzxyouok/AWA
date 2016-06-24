//
//  MoodViewController.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 16/1/21.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "MoodViewController.h"

@interface MoodViewController ()

@end

@implementation MoodViewController

+ (id)spawn {
    return [[MoodViewController alloc] initWithNibName:@"StyleViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"MOOD";
        self.itemTitle = @"MOOD";
        self.itemSubtitle = @"Find playlists by mood.";
        self.backgroundName = @"background_4.jpg";
    }
    return self;
}

@end