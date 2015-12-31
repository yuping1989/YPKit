//
//  UIViewController+YPKit.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
extern NSString * const kNotiNightModelExchanged;
@interface UIViewController (YPKit) <MBProgressHUDDelegate>

+ (instancetype)instance;

- (void)showProgressWithText:(NSString *)text;
- (void)showProgressOnWindowWithText:(NSString *)text;
- (void)showProgressOnView:(UIView *)view text:(NSString *)text userInteractionEnabled:(BOOL)enabled;
- (void)hideProgress;

- (void)initLeftBarButtonItemWithTitle:(NSString *)title;
- (void)initLeftBarButtonItemWithTitle:(NSString *)title target:(id)target;
- (void)initLeftBarButtonItemWithImage:(UIImage *)image target:(id)target;
- (void)leftBarButtonClicked:(id)sender;

- (void)initRightBarButtonItemWithTitle:(NSString *)title;
- (void)initRightBarButtonItemWithTitle:(NSString *)title target:(id)target;
- (void)initRightBarButtonItemWithTitle:(NSString *)title
                        backgroundImage:(UIImage *)bgImage
                                 target:(id)target;
- (void)initRightBarButtonItemWithImage:(UIImage *)image target:(id)target;

- (void)rightBarButtonClicked:(id)sender;


// 键盘通知
- (void)registerKeyboardNotification;
- (void)removeKeyboardNotification;
- (void)keyboardWillShowWithRect:(CGRect)keyboardRect animationDuration:(CGFloat)duration;
- (void)keyboardWillHideWithRect:(CGRect)keyboardRect animationDuration:(CGFloat)duration;
//点击背景view的时候，关闭键盘
- (void)hideKeyboardWhenTapBackground;

- (void)addNightModelExchangedObserver;
- (void)nightModelExchanged:(NSNotification *)notification;

- (void)setProgressHUD:(MBProgressHUD *)progressHUD;
- (MBProgressHUD *)progressHUD;

- (BOOL)isViewInBackground;
- (UIViewController *)topPresentedViewController;
- (void)presentNavControllerWithRootController:(UIViewController *)controller;
- (void)setScrollViewContentHeight:(CGFloat)height;
@end
