//
//  UIViewController+YPKit.h
//  YPKit
//
//  Created by 喻平 on 14-5-12.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YPKit)

/**
 *  将UIViewController的类名作为NibName，使用initWithNibName方法，返回UIViewController对象
 */
+ (instancetype)viewControllerFromNib;

/**
 *  创建左右导航栏按钮
 */
- (void)setLeftBarButtonItemTitle:(NSString *)title block:(void (^)(UIBarButtonItem *item))block;
- (void)setLeftBarButtonItemImage:(UIImage *)image block:(void (^)(UIBarButtonItem *item))block;

- (void)setRightBarButtonItemTitle:(NSString *)title block:(void (^)(UIBarButtonItem *item))block;
- (void)setRightBarButtonItemImage:(UIImage *)image block:(void (^)(UIBarButtonItem *item))block;

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
