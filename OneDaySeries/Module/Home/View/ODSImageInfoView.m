//
//  ODSImageInfoView.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/7/5.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSImageInfoView.h"

@interface ODSImageInfoView()

@property (nonatomic, weak) UITextView *textView;

@end

@implementation ODSImageInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIView *containerView = [[UIView alloc] init];
        containerView.backgroundColor = [UIColor colorWithWhite:0.f alpha:.8];
        [self addSubview:containerView];
        
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_centerY).mas_offset(0);
            make.left.bottom.right.mas_equalTo(self).mas_offset(0);
        }];
        
        UITextView *textView = [[UITextView alloc] init];
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor whiteColor];
        textView.editable = NO;
        textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        [containerView addSubview:textView];
        self.textView = textView;
        
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(containerView).insets(UIEdgeInsetsMake(10, 0, 10, 0));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setImageInfo:(NSString *)imageInfo {
    _imageInfo = imageInfo;
    self.textView.text = imageInfo;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 6.f;
    style.firstLineHeadIndent = 0.f;
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:imageInfo attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.f], NSForegroundColorAttributeName: [UIColor whiteColor], NSParagraphStyleAttributeName: style}];
}

- (void)show {
//    [UIView animateWithDuration:1.
//                          delay:0.
//         usingSpringWithDamping:.7
//          initialSpringVelocity:15
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         [self mas_updateConstraints:^(MASConstraintMaker *make) {
//                             make.top.mas_equalTo(self.superview).mas_offset(0);
//                         }];
//                         [self.superview layoutIfNeeded];
//                     }
//                     completion:nil];
    [UIView animateWithDuration:.5f animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.superview).mas_offset(0);
        }];
        [self.superview layoutIfNeeded];
    }];
}

- (void)hide {
//    [UIView animateWithDuration:1.
//                          delay:0.
//         usingSpringWithDamping:.7
//          initialSpringVelocity:15
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         [self mas_updateConstraints:^(MASConstraintMaker *make) {
//                             make.top.mas_equalTo(self.superview).mas_offset(CGRectGetHeight(self.superview.frame));
//                         }];
//                         [self.superview layoutIfNeeded];
//                     }
//                     completion:nil];
    [UIView animateWithDuration:.5f animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.superview).mas_offset(CGRectGetHeight(self.superview.frame));
        }];
        [self.superview layoutIfNeeded];
    }];
}

@end
