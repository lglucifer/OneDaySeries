//
//  ODSImageCardCell.h
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSCardScrollViewCell.h"
#import "ODSCardDelegate.h"

@interface ODSImageCardCell : ODSCardScrollViewCell

@property (nonatomic, weak) id<ODSCardDelegate> imageCardDelegate;

@end
