//
//  AnimationDotLoadingView.m
//  OneDaySeries
//
//  Created by TaoXinle on 16/7/18.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "AnimationDotLoadingView.h"
@interface AnimationDotLoadingView()

@end
@implementation AnimationDotLoadingView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.hidden = YES;
        self.layer.cornerRadius = frame.size.width/2;
        self.layer.masksToBounds = YES;
    }
    return self;
}

-(void)showInView:(UIView *)view
{
    if (![self superview]) {
        [view addSubview:self];
    }
    self.hidden = NO;
    self.transform = CGAffineTransformMakeScale(1, 1);
    self.alpha = 1;
    [UIView animateWithDuration:1 animations:^{
        self.transform = CGAffineTransformMakeScale(5, 5);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self continueAnimation];
    }];
}
-(void)continueAnimation
{
    [self showInView:nil];
}
-(void)dismiss
{
    self.hidden = YES;
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
