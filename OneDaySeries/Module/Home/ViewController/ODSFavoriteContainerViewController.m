//
//  ODSFavoriteContainerViewController.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/7/5.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSFavoriteContainerViewController.h"

@implementation ODSFavoriteContainerViewController

- (NSString *)title {
    return @"我的收藏";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    dispatch_async(dispatch_queue_create(NULL, NULL), ^{
        NSMutableArray *asyncItems = [[NSMutableArray alloc] initWithCapacity:100];
        for (int i = 0; i < 1; i++) {
            NSInteger mediaType = arc4random() % 3;
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
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

@end
