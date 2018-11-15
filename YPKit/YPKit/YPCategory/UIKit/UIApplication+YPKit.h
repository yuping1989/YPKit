//
//  UIApplication+YPKit.h
//  YPKit
//
//  Created by 喻平 on 16/6/23.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YPNetworkStatus) {
    YPNetworkStatusUnknown          = -1,
    YPNetworkStatusNotReachable     = 0,
    YPNetworkStatusReachableVia2G   = 1,
    YPNetworkStatusReachableVia3G   = 2,
    YPNetworkStatusReachableVia4G   = 3,
    YPNetworkStatusReachableViaLTE  = 4,
    YPNetworkStatusReachableViaWiFi = 5,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (YPKit)

/**
 *  Bundle Name
 */
+ (nullable NSString *)appBundleName;

/**
 *  Bundle Display Name
 */
+ (nullable NSString *)appBundleDisplayName;

/**
 *  Bundle ID
 */
+ (nullable NSString *)appBundleID;

/**
 *  版本号，例如：1
 */
+ (nullable NSString *)appVersion;

/**
 *  版本名称，例如：1.2.0
 */
+ (nullable NSString *)appShortVersionString;

/**
 *  app启动图
 */
+ (UIImage *)appLaunchImage;

/**
 *  主window
 */
+ (UIWindow *)mainWindow;

/**
 *  根据app状态栏获取网络状态
 */
+ (YPNetworkStatus)networkStatusFromStateBar;

/**
 *  判断程序是否为从AppStore安装
 */
+ (BOOL)isPirated;

/**
 *  是否为调试模式
 */
+ (BOOL)isBeingDebugged;

/**
 *  返回AppDelegate对象
 */
+ (id)appDelegate;

+ (void)hideKeyboard;

+ (void)call:(NSString *)phone;

+ (void)openURLString:(NSString *)URLString;

@end

NS_ASSUME_NONNULL_END
