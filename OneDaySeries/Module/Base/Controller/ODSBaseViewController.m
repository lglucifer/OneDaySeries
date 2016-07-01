//
//  ODSBaseViewController.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSBaseViewController.h"

@implementation ODSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chaifei_nav_title"]];
    
    if (self.navigationController.viewControllers.count >= 2) {
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                           style:UIBarButtonItemStyleDone
                                                                          target:self
                                                                          action:@selector(inner_Pop:)];
        self.navigationItem.leftBarButtonItem = leftButtonItem;
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.f], NSForegroundColorAttributeName: [UIColor colorWithRGB:0x03225C]} forState:UIControlStateNormal];
        [self.navigationItem.leftBarButtonItem setTitlePositionAdjustment:UIOffsetMake(10, 0) forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)inner_Pop:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
