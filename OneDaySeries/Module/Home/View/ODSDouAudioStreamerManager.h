//
//  ODSDouAudioStreamerManager.h
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/7/4.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioStreamer.h"
#import "DOUAudioVisualizer.h"
#import "DOUAudioFileProvider.h"

@interface ODSDouAudioStreamerManager : NSObject

@property (nonatomic, strong) DOUAudioStreamer *streamer;
@property (nonatomic, strong) DOUAudioVisualizer *audioVisualizer;

+ (instancetype)sharedManager;

@end
