//
//  ODSTextCardCell.h
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSCardWebViewCell.h"
#import "ODSCardDelegate.h"

@interface ODSTextCardCell : ODSCardWebViewCell

@property (nonatomic, weak) id<ODSCardDelegate> textCardDelegate;

- (void)loadHtml;

@end
