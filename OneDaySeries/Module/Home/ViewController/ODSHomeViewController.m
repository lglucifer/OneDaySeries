//
//  ODSHomeViewController.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSHomeViewController.h"
#import "ODSSettingViewController.h"

#import "AnimationDotLoadingView.h"

@interface ODSHomeViewController()

@property (nonatomic,strong) AnimationDotLoadingView * aniView;

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
    
    self.collectionView.hidden = YES;
    
    
    self.aniView = [[AnimationDotLoadingView alloc] initWithFrame:CGRectMake(ODSScreenWidth/2-5, 200, 10, 10)];
    self.aniView.backgroundColor = [UIColor colorWithHexString:@"#4b5c84"];
    [self.aniView showInView:self.view];

    
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
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [_spinner dismiss];
                [_aniView dismiss];
                self.collectionView.hidden = NO;
                [self.collectionView reloadData];
            });
        });
    });
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

@end
