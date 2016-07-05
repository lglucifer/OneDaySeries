//
//  ODSTextCardCell.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSTextCardCell.h"
#import "TFHpple.h"

@interface ODSTextCardCell()

@property (nonatomic, strong) ODSTextCardModel *textCardModel;

@property (nonatomic, copy) NSString *htmlString;

@property (nonatomic, strong) TFHpple *doc;

@property (nonatomic, strong) NSMutableArray *picArray;

@property (nonatomic, assign) BOOL loaded;

@end

@implementation ODSTextCardCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.operationView.hideSepLine = NO;
        self.picArray = [[NSMutableArray alloc] init];
        [self loadHtml];
    }
    return self;
}


- (void)loadData:(id)data {
    if (![data isKindOfClass:[ODSTextCardModel class]]) {
        return;
    }
    self.textCardModel = data;
}

- (void)loadHtml {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"html"];
    self.htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:self.htmlString baseURL:[NSURL fileURLWithPath:filePath]];
}

- (BOOL)card_webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (self.loaded) {
        NSString * str = request.URL.absoluteString;
        BOOL havePic = NO;
        for (int i = 0; i<self.picArray.count; i++) {
            if ([str isEqualToString:[self.picArray[i] absoluteString]]) {
                havePic = YES;
                [self.textCardDelegate imageCardSelectImage:self.picArray index:i];
            }
        }
        if (!havePic) {
            return YES;
        }
        else
            return NO;
    }
    return YES;
}

- (void)card_webViewDidFinishLoad:(UIWebView *)webView {
    NSString *lJs = @"document.documentElement.innerHTML";//获取当前网页的html
    self.htmlString = [webView stringByEvaluatingJavaScriptFromString:lJs];

    NSData *data = [self.htmlString dataUsingEncoding:NSUTF8StringEncoding];
    self.doc = [TFHpple hppleWithHTMLData:data encoding:@"UTF-8"];
    NSArray * items = [self.doc searchWithXPathQuery:@"//img"];
    //    NSLog(@"items:%@",items);
    for (TFHppleElement *item in items)
    {
        NSString * value = item.attributes[@"data-original"];
        if (!value||(value&&value.length<1)) {
            value = item.attributes[@"src"];
        }
        //        NSString *
        [self.picArray addObject:[NSURL URLWithString:value]];
    }
    self.loaded = YES;
}

@end
