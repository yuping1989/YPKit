//
//  UIViewController+YPKit.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (YPKit)  <MBProgressHUDDelegate>

/**
 *  将UIViewController的类名作为NibName，使用initWithNibName方法，返回UIViewController对象
 */
+ (instancetype)viewControllerFromNib;

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
- (void)initLeftBarButtonItemWithImage:(UIImage *)image;
- (void)initLeftBarButtonItemWithImage:(UIImage *)image target:(id)target;
- (void)leftBarButtonClicked:(id)sender;

- (void)initRightBarButtonItemWithTitle:(NSString *)title;
- (void)initRightBarButtonItemWithTitle:(NSString *)title target:(id)target;
- (void)initRightBarButtonItemWithImage:(UIImage *)image;
- (void)initRightBarButtonItemWithImage:(UIImage *)image target:(id)target;

- (void)initRightBarButtonItemWithTitle:(NSString *)title
                        backgroundImage:(UIImage *)bgImage
                                 target:(id)target;

- (void)rightBarButtonClicked:(id)sender;

/**
 *  命名原因，弃用
 */
- (void)registerKeyboardNotification;

/**
 *  命名原因，弃用
 */
- (void)removeKeyboardNotification;

/**
 *  键盘通知
 */
- (void)addKeyboardObserver;
- (void)removeKeyboardObserver;

/**
 *  键盘通知回调事件，主要用于子类重写
 *
 *  @param keyboardRect 键盘rect
 *  @param duration     键盘弹出动画的时间
 */
- (void)keyboardWillShowWithRect:(CGRect)keyboardRect animationDuration:(CGFloat)duration;
- (void)keyboardWillHideWithRect:(CGRect)keyboardRect animationDuration:(CGFloat)duration;

/**
 *  点击背景self.view的时候，关闭键盘
 */
- (void)hideKeyboardWhenTapBackground;

/**
 *  判断当前ViewController是否在顶部显示
 */
- (BOOL)isViewInBackground;

/**
 *  返回最顶部的presentedViewController
 */
- (UIViewController *)yp_topPresentedViewController;

/**
 *  返回最顶部的viewController
 */
- (UIViewController *)yp_topViewController;

/**
 *  present带导航栏的UIViewController
 */
- (void)presentNavControllerWithRootController:(UIViewController *)controller;

/**
 *  当self.view为UIScrollView时，设置它的Content Height，主要用在设置界面
 */
- (void)setScrollViewContentHeight:(CGFloat)height;

@end
