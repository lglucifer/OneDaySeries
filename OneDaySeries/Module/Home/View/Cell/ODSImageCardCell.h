//
//  ODSImageCardCell.h
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSCardScrollViewCell.h"

@class ODSImageCardCell;
@protocol ODSImageCardDelegate <NSObject>

- (void)imageCardSelectImage:(NSString *)bigImageURLString;

@end

@interface ODSImageCardCell : ODSCardScrollViewCell

@property (nonatomic, weak) id<ODSImageCardDelegate> imageCardDelegate;

@end
