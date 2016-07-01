//
//  ODSCardCollectionViewCell.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSCardCollectionViewCell.h"

@interface ODSCardCollectionViewCell()

@property (nonatomic, weak) UIView *containerView;

@end

@implementation ODSCardCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIView *containerView = [[UIView alloc] init];
        containerView.layer.cornerRadius = 10.f;
        containerView.layer.masksToBounds = YES;
        [self.contentView addSubview:containerView];
        self.containerView = containerView;
        
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
        
        [self setupSubviewWithContainerView:containerView];
    }
    return self;
}

- (void)setupSubviewWithContainerView:(UIView *)containerView {
    
}

- (void)loadData:(id)data {
    
}

@end
