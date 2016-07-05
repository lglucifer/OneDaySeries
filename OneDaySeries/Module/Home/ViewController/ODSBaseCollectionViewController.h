//
//  ODSCollectionViewController.h
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/7/5.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSBaseViewController.h"
#import "ODSCardModel.h"

@interface ODSBaseCollectionViewController : ODSBaseViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *items;

@end
