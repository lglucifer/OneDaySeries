//
//  ODSDouAudioStreamerManager.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/7/4.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSDouAudioStreamerManager.h"

@implementation ODSDouAudioStreamerManager

+ (instancetype)sharedManager {
    static ODSDouAudioStreamerManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[ODSDouAudioStreamerManager alloc] init];
    });
    return _manager;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

@end
