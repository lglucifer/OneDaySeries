//
//  ODSCollectionViewController.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/7/5.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSBaseCollectionViewController.h"
#import "ODSCardCollectionViewFlowLayout.h"
#import "ODSAudioCardCell.h"
#import "ODSTextCardCell.h"
#import "ODSImageCardCell.h"
#import "ODSNavigationController.h"
#import "ACImageBrowser.h"
#import "ODSImageInfoView.h"
#import "XZMRefresh.h"

@interface ODSBaseCollectionViewController()<ODSCardDelegate, ACImageBrowserDelegate>

@property (nonatomic, weak) ODSImageInfoView *imageInfoView;

@end

@implementation ODSBaseCollectionViewController

- (void)inner_Refresh:(id)sender {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    ODSCardCollectionViewFlowLayout *flowLayout = [[ODSCardCollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width - 20,
                                     self.view.bounds.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame) - 20);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.alwaysBounceHorizontal = YES;
    collectionView.backgroundColor = [UIColor clearColor];
    
    [collectionView registerClass:[ODSAudioCardCell class] forCellWithReuseIdentifier:NSStringFromClass(ODSAudioCardCell.class)];
    [collectionView registerClass:[ODSImageCardCell class] forCellWithReuseIdentifier:NSStringFromClass(ODSImageCardCell.class)];
    [collectionView registerClass:[ODSTextCardCell class] forCellWithReuseIdentifier:NSStringFromClass(ODSTextCardCell.class)];
    
//    collectionView.xzm_gifHeader = [[XZMRefreshGifHeader header] setRefreshingTarget:self refreshingAction:@selector(inner_Refresh:)];
   
    [collectionView xzm_addNormalHeaderWithTarget:self action:@selector(inner_Refresh:)];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    ODSImageInfoView *imageInfoView = [[ODSImageInfoView alloc] init];
    [self.view addSubview:imageInfoView];
    self.imageInfoView = imageInfoView;
    
    [imageInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(self.view).mas_offset(CGRectGetHeight(self.view.frame));
        make.height.mas_equalTo(self.view.mas_height);
    }];
    
    [collectionView.xzm_header beginRefreshing];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ODSAudioCardCell *audioCardCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(ODSAudioCardCell.class) forIndexPath:indexPath];
    ODSImageCardCell *imageCardCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(ODSImageCardCell.class) forIndexPath:indexPath];
    ODSTextCardCell *textCardCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(ODSTextCardCell.class) forIndexPath:indexPath];
    ODSCardModel *cardModel = self.items[indexPath.row];
    if (cardModel.mediaType == ODSCardMediaType_Image) {
        imageCardCell.imageCardDelegate = self;
        [imageCardCell loadData:cardModel];
        return imageCardCell;
    } else if (cardModel.mediaType == ODSCardMediaType_Audio) {
        [audioCardCell loadData:cardModel];
        return audioCardCell;
    } else {
        textCardCell.textCardDelegate = self;
        [textCardCell loadData:cardModel];
        return textCardCell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

#pragma mark --

- (void)imageCardShowImageInfo:(NSString *)imageInfo {
    self.imageInfoView.imageInfo = @"我喜欢创造新的三维世界，提出一些有悖于 “常理” 的东西。大家都太迷信 “常理” 了，但我总觉得一切可以大有不同，始终在寻找那些看不见的东西。为了拍摄那组沙漠的照片，我驱车驶入了摩洛哥的无人区。那里的空旷和浩淼是如此迷人，很难想象曾是一片汪洋，地能喷薄欲出。于是我就在想，这里再过几个世纪后又会变成怎样的场景呢？就像如果给你看两百年前纽约的照片，你肯定也会认为那是幻境。\n卡上就打开撒开了的就撒旦了卡三等奖拉萨的哈哈阿里肯德基的。我喜欢创造新的三维世界，提出一些有悖于 “常理” 的东西。大家都太迷信 “常理” 了，但我总觉得一切可以大有不同，始终在寻找那些看不见的东西。为了拍摄那组沙漠的照片，我驱车驶入了摩洛哥的无人区。那里的空旷和浩淼是如此迷人，很难想象曾是一片汪洋，地能喷薄欲出。于是我就在想，这里再过几个世纪后又会变成怎样的场景呢？就像如果给你看两百年前纽约的照片，你肯定也会认为那是幻境。\n卡上就打开撒开了的就撒旦了卡三等奖拉萨的哈哈阿里肯德基的。我喜欢创造新的三维世界，提出一些有悖于 “常理” 的东西。大家都太迷信 “常理” 了，但我总觉得一切可以大有不同，始终在寻找那些看不见的东西。为了拍摄那组沙漠的照片，我驱车驶入了摩洛哥的无人区。那里的空旷和浩淼是如此迷人，很难想象曾是一片汪洋，地能喷薄欲出。于是我就在想，这里再过几个世纪后又会变成怎样的场景呢？就像如果给你看两百年前纽约的照片，你肯定也会认为那是幻境。\n卡上就打开撒开了的就撒旦了卡三等奖拉萨的哈哈阿里肯德基的。";
    [self.imageInfoView show];
}

- (void)imageCardSelectImage:(NSArray *)images index:(NSInteger)index {
    NSMutableArray *browserImages = [NSMutableArray arrayWithArray:images];
    ACImageBrowser *browser = [[ACImageBrowser alloc] initWithImagesURLArray:browserImages];
    browser.delegate = self;
    [browser setPageIndex:index];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.navigationBarHidden = YES;
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)dismissAtIndex:(NSInteger)index {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
