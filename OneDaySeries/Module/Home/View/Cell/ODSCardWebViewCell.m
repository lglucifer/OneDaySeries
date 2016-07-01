//
//  ODSCardWebViewCell.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/7/1.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSCardWebViewCell.h"

@interface ODSCardWebViewCell()<UIWebViewDelegate>

@end

@implementation ODSCardWebViewCell

- (void)setupSubviewWithContainerView:(UIView *)containerView {
    UIWebView *webView = [[UIWebView alloc] init];
    webView.backgroundColor = [UIColor colorWithRGB:0xF5F3C7];
    webView.scrollView.backgroundColor = [UIColor colorWithRGB:0xF5F3C7];
    webView.opaque = NO;
    webView.delegate = self;
    [containerView addSubview:webView];
    self.webView = webView;
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(containerView).insets(UIEdgeInsetsZero);
    }];
    
    ODSMoreOperationView *operationView = [[ODSMoreOperationView alloc] initWithFrame:CGRectZero];
    operationView.hidden = YES;
    [webView.scrollView addSubview:operationView];
    self.operationView = operationView;
    
//    UIView *webBrowserView = nil;
//    for (UIView *subview in self.subviews) {
//        if ([subview isKindOfClass:NSClassFromString(@"UIWebBrowserView")]) {
//            webBrowserView = subview;
//            continue;
//        }
//    }
//    [operationView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.webView.scrollView);
////        make.bottom.mas_equalTo(self.webView.scrollView.mas_bottom).mas_offset(-10);
//        make.top.mas_equalTo(webBrowserView.mas_bottom).mas_offset(10);
//        make.width.mas_equalTo(self.webView.scrollView);
//        make.height.mas_equalTo(30);
//    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.operationView.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.operationView.hidden = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.operationView.hidden = NO;
    CGRect frame = webView.frame;
//    frame.size.height = self.bounds.size.height;
//    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    frame.size.height += 40;
////    webView.frame = frame;
    webView.scrollView.contentSize = frame.size;
//    [webView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(frame.size.height);
//    }];
}

@end
