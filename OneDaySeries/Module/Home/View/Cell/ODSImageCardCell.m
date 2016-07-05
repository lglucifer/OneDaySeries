//
//  ODSImageCardCell.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSImageCardCell.h"

@interface ODSImageCardCell()

@property (nonatomic, strong) ODSImageCardModel *imageCardModel;
@property (nonatomic, weak) UILabel *titleLb;
@property (nonatomic, weak) UILabel *authorLb;

@property (nonatomic, weak) UIImageView *thumbImageV;
@property (nonatomic, weak) UIButton *imageInfoBtn;

@end

@implementation ODSImageCardCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.font = [UIFont boldSystemFontOfSize:15.f];
        titleLb.textAlignment = NSTextAlignmentCenter;
        titleLb.text = @"手心里的萤火虫";
        titleLb.numberOfLines = 2;
        titleLb.textColor = [UIColor colorWithRGB:0x03225C];
        [self.scrollView addSubview:titleLb];
        self.titleLb = titleLb;
        
        UILabel *authorLb = [[UILabel alloc] init];
        authorLb.font = [UIFont systemFontOfSize:13.f];
        authorLb.textAlignment = NSTextAlignmentCenter;
        authorLb.text = @"莫小白";
        authorLb.textColor = [UIColor colorWithRGB:0x0F3775];
        [self.scrollView addSubview:authorLb];
        self.authorLb = authorLb;
        
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.scrollView).mas_offset(30);
            make.centerX.mas_equalTo(self.scrollView).mas_offset(0);
            make.width.mas_equalTo(self.scrollView).mas_equalTo(-100);
            make.height.lessThanOrEqualTo(@((ceil(titleLb.font.lineHeight) + 1) * 2));
        }];
        
        [authorLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLb.mas_bottom).mas_offset(10);
            make.width.mas_equalTo(self.scrollView).mas_equalTo(-100);
            make.centerX.mas_equalTo(titleLb.mas_centerX);
        }];
        
        UIImageView *thumbImageV = [[UIImageView alloc] init];
        thumbImageV.userInteractionEnabled = YES;
        [self.scrollView addSubview:thumbImageV];
        self.thumbImageV = thumbImageV;
        
        UIButton *imageInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageInfoBtn setImage:[UIImage imageNamed:@"image_info"] forState:UIControlStateNormal];
        [imageInfoBtn addTarget:self action:@selector(inner_ShowImageText:) forControlEvents:UIControlEventTouchUpInside];
        [thumbImageV addSubview:imageInfoBtn];
        self.imageInfoBtn = imageInfoBtn;
    
        [thumbImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.scrollView).mas_offset(0);
        }];
        
        [imageInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(thumbImageV);
        }];
        
        [self.operationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView);
            make.top.mas_equalTo(thumbImageV.mas_bottom).mas_offset(10);
            make.width.mas_equalTo(self.scrollView.mas_width);
            make.height.mas_equalTo(30);
        }];
        self.operationView.hideSepLine = NO;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inner_ShowBigImage:)];
        [self.thumbImageV addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)loadData:(id)data {
    if (![data isKindOfClass:[ODSImageCardModel class]]) {
        return;
    }
    self.imageCardModel = data;
    [self.thumbImageV sd_setImageWithURL:[NSURL URLWithString:self.imageCardModel.thumbImageURLString]];
    if (self.imageCardModel.layoutType == ODSImageCardLayout_Horizontal) {
        CGFloat titleLbTopOffset = 60;
        CGFloat thumbTopOffset = 50;
        CGFloat operationTopOffset = 50;
        if (iPhone4) {
            titleLbTopOffset = 30;
            thumbTopOffset = 30;
            operationTopOffset = 30;
        }
        CGFloat radio = self.imageCardModel.height / self.imageCardModel.width;
        [self.titleLb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.scrollView).mas_offset(titleLbTopOffset);
        }];
        [self.thumbImageV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.authorLb.mas_bottom).mas_offset(thumbTopOffset);
            make.width.mas_equalTo(self.scrollView).mas_equalTo(-20);
            make.height.mas_equalTo(self.thumbImageV.mas_width).multipliedBy(radio);
        }];
        
        [self.operationView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.thumbImageV.mas_bottom).mas_offset(operationTopOffset);
        }];
    } else {
        CGFloat radio = self.imageCardModel.width / self.imageCardModel.height;
        [self.titleLb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.scrollView).mas_offset(30);
        }];
        [self.thumbImageV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.authorLb.mas_bottom).mas_offset(20);
            make.height.mas_equalTo(self.scrollView).mas_equalTo(-140);
            make.width.mas_equalTo(self.thumbImageV.mas_height).multipliedBy(radio);
        }];
        
        [self.operationView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.thumbImageV.mas_bottom).mas_offset(10);
        }];
    }
}

- (void)inner_ShowBigImage:(UITapGestureRecognizer *)tap {
    NSArray *images = @[[NSURL URLWithString:self.imageCardModel.bigImageURLString]];
    [self.imageCardDelegate imageCardSelectImage:images index:0];
}

- (void)inner_ShowImageText:(UIButton *)sender {
    [self.imageCardDelegate imageCardShowImageInfo:@""];
}

@end
