//
//  DiscoveryViewController.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 15/11/3.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "DiscoveryCollectionViewCell.h"

static NSString * const reuseIdentifier = @"Cell";

@interface DiscoveryViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation DiscoveryViewController

- (id)init {
    if (self = [super init]) {
        self.title = @"DISCOVERY";
        self.itemTitle = @"DISCOVERY";
        self.itemSubtitle = @"Playlists that you'll love.";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = _collectionView;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"DiscoveryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier];
    
    [self configBackgroundImage:[UIImage imageNamed:@"background_1.jpg"]
           foregroundScrollView:_collectionView];
    
    [self reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(_collectionView.width / 4, _collectionView.width / 4);
}

- (void)reloadData {
    self.dataList = [Mock mockMusicList];
    
    [self.collectionView reloadData];
}

#pragma mark - Collection View

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DiscoveryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell reloadInfo:_dataList[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    self.headerView.width = view.width;
    [view addSubview:self.headerView];
    
    return view;
}

@end
