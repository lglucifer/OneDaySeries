//
//  ODSMoreOperationView.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSMoreOperationView.h"

@interface ODSMoreOperationView()

@property (nonatomic, weak) UIButton *likeBtn;
@property (nonatomic, weak) UIButton *shareBtn;

@property (nonatomic, weak) UILabel *likeNumLb;
@property (nonatomic, weak) UILabel *shareNumLb;

@property (nonatomic, weak) UIView *sepLine;

@end

@implementation ODSMoreOperationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [likeBtn setImage:[UIImage imageNamed:@"chaifei_like"] forState:UIControlStateNormal];
        [likeBtn setImage:[UIImage imageNamed:@"chaifei_liked"] forState:UIControlStateSelected];
        [likeBtn addTarget:self action:@selector(inner_HandleLike:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:likeBtn];
        self.likeBtn = likeBtn;
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareBtn setImage:[UIImage imageNamed:@"chaifei_Share"] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(inner_HandleShare:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shareBtn];
        self.shareBtn = shareBtn;
        
        UILabel *likeNumLb = [[UILabel alloc] init];
        likeNumLb.font = [UIFont systemFontOfSize:12.f];
        likeNumLb.textColor = [UIColor colorWithRGB:0x0F3775];
        likeNumLb.text = @"123";
        [self addSubview:likeNumLb];
        self.likeNumLb = likeNumLb;
        
        UILabel *shareNumLb = [[UILabel alloc] init];
        shareNumLb.font = [UIFont systemFontOfSize:12.f];
        shareNumLb.textColor = [UIColor colorWithRGB:0x0F3775];
        shareNumLb.text = @"123";
        [self addSubview:shareNumLb];
        self.shareNumLb = shareNumLb;
        
        UIView *sepLine = [[UIView alloc] init];
        sepLine.backgroundColor = [UIColor colorWithRGB:0x0F3775];
        [self addSubview:sepLine];
        self.sepLine = sepLine;
        
        [likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self).mas_offset(-100);
            make.centerY.mas_equalTo(self).mas_offset(0);
        }];
        
        [likeNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(likeBtn.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(likeBtn).mas_offset(0);
        }];
        
        [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self).mas_offset(100);
            make.centerY.mas_equalTo(self).mas_offset(0);
        }];
        
        [shareNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(shareBtn.mas_left).mas_offset(-5);
            make.bottom.mas_equalTo(shareBtn).mas_offset(0);
        }];
        
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(20);
            make.right.mas_equalTo(self).mas_offset(-20);
            make.top.mas_equalTo(self).mas_offset(0);
            make.height.mas_equalTo(.5);
        }];
    }
    return self;
}

- (void)setHideSepLine:(BOOL)hideSepLine {
    _hideSepLine = hideSepLine;
    self.sepLine.hidden = hideSepLine;
}

- (void)inner_HandleLike:(UIButton *)sender {
    
}

- (void)inner_HandleShare:(UIButton *)sender {
    
}

@end
