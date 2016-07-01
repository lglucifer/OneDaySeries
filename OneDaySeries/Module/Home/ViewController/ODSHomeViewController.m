//
//  ODSHomeViewController.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSHomeViewController.h"
#import "ODSCardCollectionViewFlowLayout.h"
#import "ODSCardModel.h"
#import "ODSAudioCardCell.h"
#import "ODSTextCardCell.h"
#import "ODSImageCardCell.h"
#import "ODSNavigationController.h"
#import "ODSSettingViewController.h"

@interface ODSHomeViewController()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *items;

@property (nonatomic, weak) ODSTextCardCell *textCardCell;

@end

@implementation ODSHomeViewController

- (void)inner_PushSetting:(UIBarButtonItem *)sender {
    ODSSettingViewController * setv = [[ODSSettingViewController alloc] init];
    [self.navigationController pushViewController:setv animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIImage *image = [UIImage imageNamed:@"chaifei_menu"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(inner_PushSetting:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    ODSCardCollectionViewFlowLayout *flowLayout = [[ODSCardCollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width - 20,
                                     self.view.bounds.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame) - 20);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    
    [collectionView registerClass:[ODSAudioCardCell class] forCellWithReuseIdentifier:NSStringFromClass(ODSAudioCardCell.class)];
    [collectionView registerClass:[ODSImageCardCell class] forCellWithReuseIdentifier:NSStringFromClass(ODSImageCardCell.class)];
    [collectionView registerClass:[ODSTextCardCell class] forCellWithReuseIdentifier:NSStringFromClass(ODSTextCardCell.class)];

    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    dispatch_async(dispatch_queue_create(NULL, NULL), ^{
        NSMutableArray *asyncItems = [[NSMutableArray alloc] initWithCapacity:100];
        for (int i = 0; i < 100; i++) {
            NSInteger mediaType = arc4random() % 3;
            if (i == 0) {
                mediaType = 0;
            }
            if (mediaType == 0) {
                ODSAudioCardModel *audioCardModel = [[ODSAudioCardModel alloc] init];
                audioCardModel.mediaType = ODSCardMediaType_Audio;
                [asyncItems addObject:audioCardModel];
            } else if (mediaType == 1) {
                ODSImageCardModel *imageCardModel = [[ODSImageCardModel alloc] init];
                imageCardModel.mediaType = ODSCardMediaType_Image;
                if (i % 2 == 0) {
                    UIImage *image = [UIImage imageNamed:@"horizontal_image"];
                    imageCardModel.width = image.size.width;
                    imageCardModel.height = image.size.height;
                    imageCardModel.thumbImageURLString = @"horizontal_image";
                    imageCardModel.layoutType = ODSImageCardLayout_Horizontal;
                } else {
                    UIImage *image = [UIImage imageNamed:@"vertical_image"];
                    imageCardModel.width = image.size.width;
                    imageCardModel.height = image.size.height;
                    imageCardModel.thumbImageURLString = @"vertical_image";
                    imageCardModel.layoutType = ODSImageCardLayout_Vertical;
                }
                [asyncItems addObject:imageCardModel];
            } else if (mediaType == 2) {
                ODSTextCardModel *textCardModel = [[ODSTextCardModel alloc] init];
                textCardModel.mediaType = ODSCardMediaType_Text;
                [asyncItems addObject:textCardModel];
            }
        }
        self.items = asyncItems.copy;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    });
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ODSAudioCardCell *audioCardCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(ODSAudioCardCell.class) forIndexPath:indexPath];
    ODSImageCardCell *imageCardCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(ODSImageCardCell.class) forIndexPath:indexPath];
    ODSTextCardCell *textCardCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(ODSTextCardCell.class) forIndexPath:indexPath];
    ODSCardModel *cardModel = self.items[indexPath.row];
    if (cardModel.mediaType == ODSCardMediaType_Image) {
        [imageCardCell loadData:cardModel];
        return imageCardCell;
    } else if (cardModel.mediaType == ODSCardMediaType_Audio) {
        [audioCardCell loadData:cardModel];
        return audioCardCell;
    } else {
        [textCardCell loadData:cardModel];
        return textCardCell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    if ([cell isKindOfClass:[ODSTextCardCell class]]) {
//        
//    }
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"didEndDisplayingCell");
//    if ([cell isKindOfClass:[ODSTextCardCell class]]) {
//        self.textCardCell = (ODSTextCardCell *)cell;
//    }
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:scrollView.contentOffset];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
}

@end
