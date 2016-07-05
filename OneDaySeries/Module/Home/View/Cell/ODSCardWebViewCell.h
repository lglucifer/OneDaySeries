//
//  ODSCardWebViewCell.h
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/7/1.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSCardCollectionViewCell.h"
#import "DMWebView.h"

@interface ODSCardWebViewCell : ODSCardCollectionViewCell

@property (nonatomic, weak) DMWebView *webView;

- (void)card_webViewDidFinishLoad:(UIWebView *)webView;
- (BOOL)card_webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

@end
