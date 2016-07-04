//
//  ODSAudioPlayView.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSAudioPlayView.h"
#import <MediaPlayer/MediaPlayer.h>
#include <CommonCrypto/CommonDigest.h>
#import "ODSDouAudioStreamerManager.h"

static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;

@interface ODSAudioPlayView() {
    BOOL _layerContainsAnimation;
}

@property (nonatomic, weak) UIImageView *albumImageV;
@property (nonatomic, weak) UIButton *playBtn;
@property (nonatomic, weak) UILabel *titleLb;
@property (nonatomic, weak) UILabel *audioTitleLb;
@property (nonatomic, weak) UIProgressView *progressView;

@property (nonatomic, strong) NSMutableDictionary *nowPlayingInfo;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ODSAudioPlayView

- (void)dealloc {
    [self inner_CancelStreamer];
    _track = nil;
    _audioVisualizer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *albumImageV = [[UIImageView alloc] init];
        [self addSubview:albumImageV];
        self.albumImageV = albumImageV;
        
        CGFloat albumImageWidth = ODSScreenWidth - 60;
        
        [albumImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self).mas_offset(0);
            make.top.mas_equalTo(self).mas_equalTo(0);
            make.width.height.mas_equalTo(albumImageWidth);
        }];
        
        albumImageV.layer.cornerRadius = (albumImageWidth) / 2;
        albumImageV.layer.masksToBounds = YES;
        
        UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [playBtn setImage:[UIImage imageNamed:@"Music_Play_Btn"] forState:UIControlStateNormal];
        [playBtn addTarget:self action:@selector(inner_Play:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:playBtn];
        self.playBtn = playBtn;
        
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLb.font = [UIFont systemFontOfSize:14.f];
        titleLb.textAlignment = NSTextAlignmentRight;
//        titleLb.text = @"〖唯美纯音〗不需要歌词,也可以打动你的心";
        titleLb.textColor = [UIColor colorWithRGB:0x03225C];
        [self addSubview:titleLb];
        self.titleLb = titleLb;
        
        UILabel *audioTitleLb = [[UILabel alloc] initWithFrame:CGRectZero];
        audioTitleLb.font = [UIFont systemFontOfSize:12.f];
//        audioTitleLb.text = @"いつも何度でも";
        audioTitleLb.textAlignment = NSTextAlignmentRight;
        audioTitleLb.textColor = [UIColor colorWithRGB:0x0F3775];
        [self addSubview:audioTitleLb];
        self.audioTitleLb = audioTitleLb;
        
        UIProgressView *progressView = [[UIProgressView alloc] init];
        progressView.progressTintColor = [UIColor yellowColor];
        [self addSubview:progressView];
        self.progressView = progressView;
        
        [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(3);
            make.right.mas_equalTo(self).mas_offset(-3);
            make.bottom.mas_equalTo(self).mas_offset(-5);
        }];
        
        [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(5);
            make.bottom.mas_equalTo(progressView.mas_top).mas_offset(-15);
        }];
        
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(-5);
            make.top.mas_equalTo(playBtn).mas_offset(0);
            make.width.mas_equalTo(200);
        }];
        
        [audioTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(-5);
            make.top.mas_equalTo(titleLb.mas_bottom).mas_offset(10);
            make.width.mas_equalTo(200);
        }];
        
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        rotationAnimation.duration = 15;
        rotationAnimation.repeatCount = MAXFLOAT;//你可以设置到最大的整数值
        rotationAnimation.cumulative = NO;
        rotationAnimation.removedOnCompletion = NO;
        rotationAnimation.fillMode = kCAFillModeForwards;
        [self.albumImageV.layer addAnimation:rotationAnimation forKey:@"Rotation"];
        self.albumImageV.layer.speed = 0.0;
        self.albumImageV.layer.timeOffset = 0;
    }
    return self;
}

- (void)inner_Play:(UIButton *)sender {
    if (!_streamer) {
        [self inner_ResetStreamer];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(inner_TimerAction:) userInfo:nil repeats:YES];
    }
    else{
        if ([_streamer status] == DOUAudioStreamerPaused ||
            [_streamer status] == DOUAudioStreamerIdle) {
            [_streamer play];
        }
        else {
            [_streamer pause];    
        }
    }
}


- (void)pauseAlbumRotation {
    CFTimeInterval pausedTime = [self.albumImageV.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.albumImageV.layer.speed = 0.0;
    self.albumImageV.layer.timeOffset = pausedTime;
}

- (void)resumeAlbumRotation {
    CFTimeInterval pausedTime = [self.albumImageV.layer timeOffset];
    self.albumImageV.layer.speed = 1.0;
    self.albumImageV.layer.timeOffset = 0.0;
    self.albumImageV.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.albumImageV.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.albumImageV.layer.beginTime = timeSincePause;
}

#pragma mark -- Streamer

- (void)inner_CancelStreamer {
    if (_streamer != nil) {
        [_streamer pause];
        [_streamer removeObserver:self forKeyPath:@"status"];
        [_streamer removeObserver:self forKeyPath:@"duration"];
        [_streamer removeObserver:self forKeyPath:@"bufferingRatio"];
        _streamer = nil;
    }
}

- (void)inner_ResetStreamer
{
    [self inner_CancelStreamer];
    
    if (!self.track) {
        NSLog(@"no track now");
    } else {
        NSString *filename = [NSString stringWithFormat:@"douas-%@DONE", [self makeSHA256ForAudioFileURL:self.track.audioFileURL]];
        NSString * localPath = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
        if ([[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
            self.track.audioFileURL = [NSURL fileURLWithPath:localPath];
        }
        
        ODSTrack *track = self.track;
        _streamer = [DOUAudioStreamer streamerWithAudioFile:track];
        [_streamer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
        [_streamer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
        [_streamer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
        
        [ODSDouAudioStreamerManager sharedManager].streamer = _streamer;
        [_streamer play];
        
        [self inner_UpdateBufferingStatus];
    }
}

#pragma mark -- Track 

- (void)setTrack:(ODSTrack *)track {
    if (!track) {
        return;
    }
    _track = track;
    self.titleLb.text = track.artist;
    self.audioTitleLb.text = track.title;
    [self.albumImageV sd_setImageWithURL:[NSURL URLWithString:track.albumUrlStr]];
}

#pragma mark -- KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kStatusKVOKey) {
        [self performSelector:@selector(inner_UpdateStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else if (context == kDurationKVOKey) {
        [self performSelector:@selector(inner_TimerAction:)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else if (context == kBufferingRatioKVOKey) {
        [self performSelector:@selector(inner_UpdateBufferingStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)inner_UpdateStatus {
    switch ([_streamer status]) {
        case DOUAudioStreamerPlaying:
            [self.playBtn setImage:[UIImage imageNamed:@"Music_Stop_Btn"] forState:UIControlStateNormal];
            [self resumeAlbumRotation];
            break;
            
        case DOUAudioStreamerPaused:
            [self.playBtn setImage:[UIImage imageNamed:@"Music_Play_Btn"] forState:UIControlStateNormal];
            [self pauseAlbumRotation];
            break;
            
        case DOUAudioStreamerIdle:
            [self.playBtn setImage:[UIImage imageNamed:@"Music_Play_Btn"] forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerFinished:
            [self inner_ResetStreamer];
            break;
            
        case DOUAudioStreamerBuffering:
            [self.playBtn setBackgroundImage:nil forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerError:
            NSLog(@"error");
            break;
    }
}

- (void)inner_TimerAction:(id)timer {
    if ([_streamer duration] == 0.0) {
        self.progressView.progress = 0.f;
    } else {
        CGFloat progress = [_streamer currentTime] / [_streamer duration];
        [self.progressView setProgress:progress animated:YES];
    }
    [self inner_SetMideaInfo];
}

- (void)inner_SetMideaInfo {
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        if (!self.nowPlayingInfo) {
            self.nowPlayingInfo = [[NSMutableDictionary alloc] init];
        }
        [self.nowPlayingInfo setObject:self.track.title forKey:MPMediaItemPropertyAlbumTitle];
        [self.nowPlayingInfo setObject:self.track.title forKey:MPMediaItemPropertyTitle];
        [self.nowPlayingInfo setObject:self.track.artist forKey:MPMediaItemPropertyArtist];
        [self.nowPlayingInfo setObject:[NSNumber numberWithFloat:[_streamer duration]] forKey:MPMediaItemPropertyPlaybackDuration];
        [self.nowPlayingInfo setObject:[NSNumber numberWithFloat:[_streamer currentTime]] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        
        if (self.albumImageV.image &&
            ![self.nowPlayingInfo objectForKey:MPMediaItemPropertyArtwork]) {
            MPMediaItemArtwork * mArt = [[MPMediaItemArtwork alloc] initWithImage:self.albumImageV.image];
            [self.nowPlayingInfo setObject:mArt forKey:MPMediaItemPropertyArtwork];
        }
        
        [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nil;
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:self.nowPlayingInfo];
    }
}

- (void)inner_UpdateBufferingStatus {
    NSLog(@"%@",[NSString stringWithFormat:@"Received %.2f/%.2f MB (%.2f %%), Speed %.2f MB/s", (double)[_streamer receivedLength] / 1024 / 1024, (double)[_streamer expectedLength] / 1024 / 1024, [_streamer bufferingRatio] * 100.0, (double)[_streamer downloadSpeed] / 1024 / 1024]);
    if ([_streamer bufferingRatio] >= 1.0) {
        NSLog(@"sha256: %@", [_streamer cachedPath]);
        if ([[NSFileManager defaultManager] fileExistsAtPath:[_streamer cachedPath]]&&![self.track.audioFileURL isFileURL]) {
            NSData * data = [NSData dataWithContentsOfFile:[_streamer cachedPath]];
            NSString *filename = [NSString stringWithFormat:@"douas-%@DONE", [self makeSHA256ForAudioFileURL:self.track.audioFileURL]];
            NSString * localPath = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
            [data writeToFile:localPath atomically:YES];
            NSError * error = nil;
            [[NSFileManager defaultManager] removeItemAtPath:[_streamer cachedPath] error:&error];
            NSLog(@"transfer it");
        }
    }
}

- (NSString *)makeSHA256ForAudioFileURL:(NSURL *)audioFileURL {
    NSString *string = [audioFileURL absoluteString];
    unsigned char hash[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256([string UTF8String], (CC_LONG)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], hash);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (size_t i = 0; i < CC_SHA256_DIGEST_LENGTH; ++i) {
        [result appendFormat:@"%02x", hash[i]];
    }
    
    return result;
}

@end
