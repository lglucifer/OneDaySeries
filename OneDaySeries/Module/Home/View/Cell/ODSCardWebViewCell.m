//
//  ODSCardWebViewCell.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/7/1.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSCardWebViewCell.h"
#import "TFHppleElement.h"

@interface ODSCardWebViewCell()<UIWebViewDelegate>

@end

@implementation ODSCardWebViewCell

- (void)setupSubviewWithContainerView:(UIView *)containerView {
    DMWebView *webView = [[DMWebView alloc] init];
    webView.backgroundColor = [UIColor colorWithRGB:0xF5F3C7];
    webView.scrollView.backgroundColor = [UIColor colorWithRGB:0xF5F3C7];
    webView.opaque = NO;
    webView.delegate = self;
    [containerView addSubview:webView];
    self.webView = webView;
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(containerView).insets(UIEdgeInsetsZero);
    }];
    
    ODSMoreOperationView *operationView = [[ODSMoreOperationView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 40)];
    operationView.hidden = YES;
    self.webView.footerView = operationView;
    self.operationView = operationView;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.operationView.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.operationView.hidden = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.operationView.hidden = NO;
    [self card_webViewDidFinishLoad:webView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return [self card_webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}

- (void)card_webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (BOOL)card_webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

@end
