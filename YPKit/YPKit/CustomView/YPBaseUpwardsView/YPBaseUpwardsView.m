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
    [YPNativeUtil  hideKeyboard];
    UIView *view = [YPNativeUtil appDelegate].window;
    if (!self.backgroundView) {
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        [self.backgroundView setTapGestureTarget:self action:@selector(cancelButtonClicked:)];
    }
    self.backgroundView.frame = view.bounds;
    self.width = view.width;
    [view addSubview:self.backgroundView];
    [view addSubview:self];
    
    self.backgroundView.alpha = 0.0f;
    self.y = view.height;
    [UIView animateWithDuration:0.25f animations:^{
        self.backgroundView.alpha = 0.3f;
        self.y = view.height - self.height;
    }];
}

- (IBAction)cancelButtonClicked:(id)sender {
    [UIView animateWithDuration:0.25f animations:^{
        self.backgroundView.alpha = 0.0f;
        self.y = self.superview.height;
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
}
@end
