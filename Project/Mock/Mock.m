//
//  Mock.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 16/1/22.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "Mock.h"

@implementation Mock

+ (NSArray *)mockMusicList {
    MusicInfo *info0 = [MusicInfo spawn];
    info0.name = @"Yesterday Once More";
    info0.singer = @"Carpenters";
    info0.icon = @"0.jpg";
    
    MusicInfo *info1 = [MusicInfo spawn];
    info1.name = @"Burning";
    info1.singer = @"Maria Arredondo";
    info1.icon = @"1.jpg";
    
    MusicInfo *info2 = [MusicInfo spawn];
    info2.name = @"Because Of You";
    info2.singer = @"Kelly Clarkson";
    info2.icon = @"2.jpg";
    
    return @[info0, info1, info2, info1, info2, info1, info0, info1, info2, info0, info1, info2, info1, info2, info1, info0, info1, info2];
}

+ (NSArray *)mockAlbumList {
    AlbumInfo *info0 = [AlbumInfo spawn];
    info0.name = @"TOP 100 NEW ARRIVAL TRACKS on AWA";
    info0.desc = @"AI / amazarashi / BLUE ENCOUNT /SKY-HI / KANA-BOON / SOLIDEMO / iKON...";
    info0.icons = @[@"0.jpg", @"1.jpg", @"2.jpg"];
    info0.musics = [self mockMusicList];
    
    AlbumInfo *info1 = [AlbumInfo spawn];
    info1.name = @"TOP 100 TRACKS on AWA";
    info1.desc = @"THE Sharehappi from 三代目 J Soul Brothers from EXILE TRIBE / EXILE /Justin Bieber / 三代目 J Soul Brother";
    info1.icons = @[@"3.jpg", @"4.jpg", @"5.jpg"];
    info1.musics = [self mockMusicList];
    
    AlbumInfo *info2 = [AlbumInfo spawn];
    info2.name = @"TOP 20 DANCE / ELECTRONIC \nTRACKS on AWA";
    info2.desc = @"Zedd / Avicii / David Guetta / Ariana Grande / David Guetta & Showtek / Major Lazer / Maroon 5 / Katy Preery";
    info2.icons = @[@"6.jpg", @"7.jpg", @"8.jpg"];
    info2.musics = [self mockMusicList];
    
    return @[info0, info1, info2, info0, info1, info2, info0, info1, info2, info0, info1, info2];
}

+ (NSArray *)mockStyleList {
    StyleInfo *info0 = [StyleInfo spawn];
    info0.name = @"POP";
    info0.icon = @"0.jpg";
    info0.albumList = [self mockAlbumList];
    
    StyleInfo *info1 = [StyleInfo spawn];
    info1.name = @"DANCE / ELECTRONIC";
    info1.icon = @"3.jpg";
    info1.albumList = [self mockAlbumList];
    
    StyleInfo *info2 = [StyleInfo spawn];
    info2.name = @"ANIMATION / VOCALOID";
    info2.icon = @"6.jpg";
    info2.albumList = [self mockAlbumList];
    
    return @[info0, info1, info2, info0, info1, info2, info0, info1, info2, info0, info1, info2];
}

@end
