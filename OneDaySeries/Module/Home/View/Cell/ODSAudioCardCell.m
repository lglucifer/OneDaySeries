
//
//  ODSAudioCardCell.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSAudioCardCell.h"
#import "ODSAudioPlayView.h"

@interface ODSAudioCardCell()

@property (nonatomic, weak) ODSAudioPlayView *audioPlayView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ODSAudioCardCell

- (void)dealloc {
    _timer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        ODSAudioPlayView *audioPlayView = [[ODSAudioPlayView alloc] init];
        [self.scrollView addSubview:audioPlayView];
        self.audioPlayView = audioPlayView;
        
        CGFloat operationViewbottomOffset = -30;
        CGFloat audioPlayViewTopOffset = 50;
        if (iPhone4) {
            operationViewbottomOffset = -15;
            audioPlayViewTopOffset = 20;
        }
        [self.operationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView.superview);
            make.bottom.mas_equalTo(self.scrollView.superview.mas_bottom).mas_offset(operationViewbottomOffset);
            make.width.mas_equalTo(self.scrollView.superview.mas_width);
            make.height.mas_equalTo(30);
        }];
        
        [audioPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.operationView.mas_top).mas_offset(-10);
            make.top.mas_equalTo(self.scrollView.superview).mas_offset(audioPlayViewTopOffset);
            make.left.mas_equalTo(self.scrollView.superview).mas_offset(5);
            make.width.mas_equalTo(self.scrollView.superview.mas_width).mas_offset(-10);
        }];
        self.operationView.hideSepLine = YES;
    }
    return self;
}

- (void)loadData:(id)data {
    if (!data) {
        return;
    }
    ODSTrack *track = [[ODSTrack alloc] init];
    track.title = @"Summer";
    track.artist = @"久石譲";
    track.albumUrlStr = @"http://7d9jfr.com1.z0.glb.clouddn.com/jiu82233.png?imageView2/2/w/500";
    track.audioFileURL = [NSURL URLWithString:@"http://7d9jfr.com1.z0.glb.clouddn.com/summerjiushir.mp3"];
    self.audioPlayView.track = track;
}

@end
