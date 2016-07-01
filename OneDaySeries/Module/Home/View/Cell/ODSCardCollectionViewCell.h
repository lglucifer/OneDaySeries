//
//  ODSCardCollectionViewCell.h
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ODSCardModel.h"
#import "ODSMoreOperationView.h"

@interface ODSCardCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) ODSMoreOperationView *operationView;

- (void)loadData:(id)data;

- (void)setupSubviewWithContainerView:(UIView *)containerView;

@end
