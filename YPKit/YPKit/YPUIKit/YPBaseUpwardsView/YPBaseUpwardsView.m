//
//  YPBaseUpwardsView.m
//  NBD2
//
//  Created by 喻平 on 16/3/18.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import "YPBaseUpwardsView.h"

@implementation YPBaseUpwardsView

- (void)show {
    UIView *window = [UIApplication sharedApplication].delegate.window;
    [self showInView:window];
}

- (void)showInView:(UIView *)view {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    if (!self.backgroundView) {
        self.backgroundView = [[UIControl alloc] init];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        
        [self.backgroundView addTarget:self
                                action:@selector(backgroundClicked:)
                      forControlEvents:UIControlEventTouchUpInside];
    }
    self.backgroundView.frame = view.bounds;
    [view addSubview:self.backgroundView];
    [view addSubview:self];
    
    self.backgroundView.alpha = 0.0f;
    CGRect frame = self.frame;
    frame.size.width = view.frame.size.width;
    frame.origin.y = view.frame.size.height;
    self.frame = frame;
    [UIView animateWithDuration:0.25f animations:^{
        self.backgroundView.alpha = 0.3f;
        CGRect frame = self.frame;
        frame.origin.y = view.frame.size.width - frame.size.height;
        self.frame = frame;
    }];
}

- (void)hideWithCompletion:(void (^)(void))completion {
    [UIView animateWithDuration:0.25f animations:^{
        self.backgroundView.alpha = 0.0f;
        CGRect frame = self.frame;
        frame.origin.y = self.superview.frame.size.height;
        self.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
            if (completion) {
                completion();
            }
            [self.backgroundView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

- (void)backgroundClicked:(id)sender {
    [self hideWithCompletion:nil];
}

@end
