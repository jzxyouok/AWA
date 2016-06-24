//
//  GenreViewController.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 16/1/21.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "GenreViewController.h"

@interface GenreViewController ()

@end

@implementation GenreViewController

+ (id)spawn {
    return [[GenreViewController alloc] initWithNibName:@"StyleViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"GENRE";
        self.itemTitle = @"GENRE";
        self.itemSubtitle = @"Find playlists by genres.";
        self.backgroundName = @"background_3.jpg";
    }
    return self;
}

@end
