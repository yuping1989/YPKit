//
//  UIViewController+YPKit.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (YPKit) <MBProgressHUDDelegate>
/**
 *  将UIViewController的类名作为NibName，使用initWithNibName方法，返回UIViewController对象
 */
+ (instancetype)instance;
/**
 *  显示等待提示框
 */
- (void)showProgressWithText:(NSString *)text;
- (void)showProgressOnWindowWithText:(NSString *)text;
- (void)showProgressOnView:(UIView *)view text:(NSString *)text userInteractionEnabled:(BOOL)enabled;
- (void)hideProgress;

- (void)setProgressHUD:(MBProgressHUD *)progressHUD;
- (MBProgressHUD *)progressHUD;

/**
 *  创建左右导航栏按钮
 */
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

/**
 *  点击背景self.view的时候，关闭键盘
 */
- (void)hideKeyboardWhenTapBackground;

/**
 *  键盘通知
 */
- (void)registerKeyboardNotification;
- (void)removeKeyboardNotification;
- (void)keyboardWillShowWithRect:(CGRect)keyboardRect animationDuration:(CGFloat)duration;
- (void)keyboardWillHideWithRect:(CGRect)keyboardRect animationDuration:(CGFloat)duration;

/**
 *  判断是否在顶部
 */
- (BOOL)isViewInBackground;

/**
 *  返回最顶部的presentedViewController
 */
- (UIViewController *)topPresentedViewController;

/**
 *  present带导航栏的UIViewController
 */
- (void)presentNavControllerWithRootController:(UIViewController *)controller;

/**
 *  当self.view为UIScrollView时，设置它的Content Height，主要用在设置界面
 */
- (void)setScrollViewContentHeight:(CGFloat)height;
@end
