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

@end
