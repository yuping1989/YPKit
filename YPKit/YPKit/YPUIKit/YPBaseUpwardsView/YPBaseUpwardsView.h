//
//  YPBaseUpwardsView.h
//  NBD2
//
//  Created by 喻平 on 16/3/18.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPBaseUpwardsView : UIView

@property (nonatomic, strong) UIControl *backgroundView;

- (void)showInWindow;
- (void)showInView:(UIView *)view;

- (void)hideWithCompletion:(void (^)(void))completion;

@end
