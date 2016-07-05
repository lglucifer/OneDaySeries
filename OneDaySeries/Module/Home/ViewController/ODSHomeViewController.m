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
#import "ACImageBrowser.h"
#import "ODSImageInfoView.h"

@interface ODSHomeViewController()<UICollectionViewDelegate, UICollectionViewDataSource, ODSCardDelegate, ACImageBrowserDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *items;

@property (nonatomic, weak) ODSTextCardCell *textCardCell;

@property (nonatomic, weak) ODSImageInfoView *imageInfoView;

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
                    imageCardModel.width = 457;
                    imageCardModel.height = 343;
                    imageCardModel.thumbImageURLString = @"http://xlimage.uzero.cn/dacfd675c59f9c9bc5021f84e64d5ff7.jpg?imageView2/2/h/200";
                    imageCardModel.bigImageURLString = @"http://xlimage.uzero.cn/dacfd675c59f9c9bc5021f84e64d5ff7.jpg";
                    imageCardModel.layoutType = ODSImageCardLayout_Horizontal;
                } else {
                    imageCardModel.width = 242;
                    imageCardModel.height = 343;
                    imageCardModel.thumbImageURLString = @"http://xlimage.uzero.cn/91Npeew9NqL.jpg?imageView2/2/h/200";
                    imageCardModel.bigImageURLString = @"http://xlimage.uzero.cn/91Npeew9NqL.jpg";
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
    
    ODSImageInfoView *imageInfoView = [[ODSImageInfoView alloc] init];
    [self.view addSubview:imageInfoView];
    self.imageInfoView = imageInfoView;
    
    [imageInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(self.view).mas_offset(CGRectGetHeight(self.view.frame));
        make.height.mas_equalTo(self.view.mas_height);
    }];
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
    
}

#pragma mark -- 

- (void)imageCardShowImageInfo:(NSString *)imageInfo {
    self.imageInfoView.imageInfo = @"我喜欢创造新的三维世界，提出一些有悖于 “常理” 的东西。大家都太迷信 “常理” 了，但我总觉得一切可以大有不同，始终在寻找那些看不见的东西。为了拍摄那组沙漠的照片，我驱车驶入了摩洛哥的无人区。那里的空旷和浩淼是如此迷人，很难想象曾是一片汪洋，地能喷薄欲出。于是我就在想，这里再过几个世纪后又会变成怎样的场景呢？就像如果给你看两百年前纽约的照片，你肯定也会认为那是幻境。";
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
