//
//  ODSNavigationController.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSNavigationController.h"

@implementation ODSNavigationController

+ (void)initialize {
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.f], NSForegroundColorAttributeName: [UIColor yellowColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
