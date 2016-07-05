//
//  ODSCardDelegate.h
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/7/5.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ODSCardDelegate <NSObject>

- (void)imageCardSelectImage:(NSArray *)images index:(NSInteger)index;

- (void)imageCardShowImageInfo:(NSString *)imageInfo;

@end
