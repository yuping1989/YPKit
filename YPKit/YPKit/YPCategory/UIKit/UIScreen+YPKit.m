//
//  UIScreen+YPKit.m
//  YPKit
//
//  Created by 喻平 on 16/6/23.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import "UIScreen+YPKit.h"

@implementation UIScreen (YPKit)

+ (CGFloat)onePixel {
    UIScreen *mainScreen = [UIScreen mainScreen];
    if (@available(iOS 8.0, *)) {
        return 1.0f / mainScreen.nativeScale;
    } else {
        return 1.0f / mainScreen.scale;
    }
}

+ (CGFloat)statusBarHeight {
    CGFloat height = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        height = statusBarManager.statusBarFrame.size.height;
    }
    return height;
}

+ (UIEdgeInsets)safeAreaInsets {
    static UIEdgeInsets insets;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            insets = window.safeAreaInsets;
        } else {
            insets = UIEdgeInsetsZero;
        }
    });
    return insets;
}

@end
