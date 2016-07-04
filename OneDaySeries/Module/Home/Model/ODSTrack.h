//
//  ODSTrack.h
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/7/4.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSBaseModel.h"
#import "DOUAudioFile.h"

@interface ODSTrack : ODSBaseModel<DOUAudioFile>

@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *albumUrlStr;
@property (nonatomic, strong) NSURL *audioFileURL;
@property (nonatomic, copy) NSString * des;

@end
