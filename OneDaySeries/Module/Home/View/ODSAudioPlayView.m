//
//  ODSAudioPlayView.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSAudioPlayView.h"

@interface ODSAudioPlayView()

@property (nonatomic, weak) UIButton *playBtn;
@property (nonatomic, weak) UILabel *titleLb;
@property (nonatomic, weak) UILabel *audioTitleLb;
@property (nonatomic, weak) UIProgressView *progressView;

@end

@implementation ODSAudioPlayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [playBtn setImage:[UIImage imageNamed:@"Music_Play_Btn"] forState:UIControlStateNormal];
        [self addSubview:playBtn];
        self.playBtn = playBtn;
        
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLb.font = [UIFont systemFontOfSize:14.f];
        titleLb.text = @"〖唯美纯音〗不需要歌词,也可以打动你的心";
        titleLb.textColor = [UIColor colorWithRGB:0x03225C];
        [self addSubview:titleLb];
        self.titleLb = titleLb;
        
        UILabel *audioTitleLb = [[UILabel alloc] initWithFrame:CGRectZero];
        audioTitleLb.font = [UIFont systemFontOfSize:12.f];
        audioTitleLb.text = @"いつも何度でも";
        audioTitleLb.textAlignment = NSTextAlignmentRight;
        audioTitleLb.textColor = [UIColor colorWithRGB:0x0F3775];
        [self addSubview:audioTitleLb];
        self.audioTitleLb = audioTitleLb;
        
        UIProgressView *progressView = [[UIProgressView alloc] init];
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
    }
    return self;
}



@end
