//
//  NoticeDetailViewController.m
//  CSLCPlay
//
//  Created by liwei on 16/5/3.
//  Copyright © 2016年 liwei. All rights reserved.
//

#import "OSDWebViewController.h"
#import "UINavigationController+SGProgress.h"


@interface OSDWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation OSDWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController showSGProgress];
    
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    [self.view addSubview:_webView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView;
{
    //[self.navigationController showSGProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[self.navigationController finishSGProgress];
    
    [self.navigationController cancelSGProgress];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    
}

@end
