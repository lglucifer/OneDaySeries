//
//  ODSTextCardCell.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSTextCardCell.h"

@interface ODSTextCardCell()

@property (nonatomic, strong) ODSTextCardModel *textCardModel;

@end

@implementation ODSTextCardCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.operationView.hideSepLine = NO;
        [self loadHtml];
    }
    return self;
}


- (void)loadData:(id)data {
    if (![data isKindOfClass:[ODSTextCardModel class]]) {
        return;
    }
    self.textCardModel = data;
//    dispatch_async(dispatch_queue_create(NULL, NULL), ^{
//    });
}

- (void)loadHtml {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:filePath]];
}

@end
