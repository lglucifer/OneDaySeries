
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

@property (nonatomic, weak) UIImageView *albumImageV;

@property (nonatomic, weak) ODSAudioPlayView *audioPlayView;

@end

@implementation ODSAudioCardCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *albumImageV = [[UIImageView alloc] init];
        albumImageV.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:albumImageV];
        self.albumImageV = albumImageV;
        
        [albumImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.scrollView).mas_offset(0);
            make.top.mas_equalTo(self.scrollView).mas_equalTo(20);
            make.width.height.mas_equalTo(self.scrollView.mas_width).mas_offset(-40);
        }];
        
        albumImageV.layer.cornerRadius = ([UIScreen mainScreen].bounds.size.width - 60) / 2;
        albumImageV.layer.masksToBounds = YES;
        
        ODSAudioPlayView *audioPlayView = [[ODSAudioPlayView alloc] init];
        [self.scrollView addSubview:audioPlayView];
        self.audioPlayView = audioPlayView;
        
        [audioPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(albumImageV.mas_bottom).mas_offset(20);
            make.left.mas_equalTo(self.scrollView).mas_offset(0);
            make.width.mas_equalTo(self.scrollView.mas_width);
            make.height.mas_equalTo(55);
        }];
        
        [self.operationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView);
            make.top.mas_equalTo(audioPlayView.mas_bottom).mas_offset(0);
            make.width.mas_equalTo(self.scrollView.mas_width);
            make.height.mas_equalTo(30);
        }];
        self.operationView.hideSepLine = YES;
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.contentView.frame), [UIScreen mainScreen].bounds.size.width - 20 + 55 + 30 + 10);
    }
    return self;
}

@end
