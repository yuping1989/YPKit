//
//  UIApplication+YPKit.h
//  NBD2
//
//  Created by 喻平 on 16/6/23.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (YPKit)

/// Bundle Name
+ (nullable NSString *)appBundleName;

/// Bundle Display Name
+ (nullable NSString *)appBundleDisplayName;

/// Bundle ID
+ (nullable NSString *)appBundleID;

/// 版本名称，例如：1.2.0
+ (nullable NSString *)appVersionName;

/// 版本号，例如：123
+ (nullable NSString *)appShortVersionString;

/// 判断程序是否为从AppStore安装
+ (BOOL)isPirated;

/// 是否为调试模式
+ (BOOL)isBeingDebugged;

/// 返回AppDelegate对象
+ (AppDelegate *)appDelegate;

+ (void)hideKeyboard;

+ (void)call:(NSString *)phone;

+ (void)openURLString:(NSString *)URLString;

// 在最上层的UIWindow上显示一个简短的提示，不会被键盘遮挡
+ (void)showToast:(NSString *)text;
+ (void)showToast:(NSString *)text
   hideAfterDelay:(NSTimeInterval)delay;

// 在最底层UIWindow上显示一个简短的提示，有键盘存在时，可能会被遮挡
+ (void)showToastInAppWindow:(NSString *)text;

+ (void)showToast:(NSString *)text
           inView:(UIView *)view
   hideAfterDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
