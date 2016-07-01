//
//  ODSCardScrollViewCell.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/7/1.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSCardScrollViewCell.h"

@interface ODSCardScrollViewCell()

@end

@implementation ODSCardScrollViewCell

- (void)setupSubviewWithContainerView:(UIView *)containerView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor colorWithRGB:0xF5F3C7];
    [containerView addSubview:scrollView];
    self.scrollView = scrollView;
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(containerView).insets(UIEdgeInsetsZero);
    }];
    
    ODSMoreOperationView *operationView = [[ODSMoreOperationView alloc] init];
    [scrollView addSubview:operationView];
    self.operationView = operationView;
}

@end
