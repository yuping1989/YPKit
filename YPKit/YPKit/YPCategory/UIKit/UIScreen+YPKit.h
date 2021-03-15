//
//  UIScreen+YPKit.h
//  YPKit
//
//  Created by 喻平 on 16/6/23.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPKitMacro.h"

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT \
({ CGFloat screen_height = [UIScreen mainScreen].bounds.size.height; \
if (F_EQUAL([UIApplication sharedApplication].statusBarFrame.size.height, 40)){ \
screen_height -= 20; \
} \
(screen_height);})
#endif

// iPhone X
#ifndef IPHONE_X
#define IPHONE_X SCREEN_EQUAL(1125, 2436)
#endif

// iPhone XR
#ifndef IPHONE_XR
#define IPHONE_XR SCREEN_EQUAL(828, 1792)
#endif

// iPhone Xs Max
#ifndef IPHONE_XS_MAX
#define IPHONE_XS_MAX SCREEN_EQUAL(1242, 2688)
#endif

// iPhone 12 Mini
#ifndef IPHONE_12_MINI
#define IPHONE_12_MINI SCREEN_EQUAL(1080, 2340)
#endif

// iPhone 12和12Pro
#ifndef IPHONE_12
#define IPHONE_12 SCREEN_EQUAL(1170, 2532)
#endif

// iPhone 12 Pro Max
#ifndef IPHONE_12_PRO_MAX
#define IPHONE_12_PRO_MAX SCREEN_EQUAL(1284, 2778)
#endif

// iPhone XR 放大模式
#ifndef IPHONE_XR_BIG_MODE
#define IPHONE_XR_BIG_MODE SCREEN_EQUAL(750, 1624)
#endif

// iPhone X系列
#ifndef IPHONE_X_SERIES
#define IPHONE_X_SERIES (IPHONE_X || IPHONE_XR || IPHONE_XS_MAX || IPHONE_XR_BIG_MODE ||  IPHONE_12_MINI || IPHONE_12 || IPHONE_12_PRO_MAX)
#endif

// Status bar height.
#ifndef STATUSBAR_HEIGHT
#define STATUSBAR_HEIGHT [UIScreen statusBarHeight]
#endif

// Navigation bar height.
#ifndef NAVIGATIONBAR_HEIGHT
#define NAVIGATIONBAR_HEIGHT 44.0f
#endif

// Status bar & navigation bar height.
#ifndef STATUSBAR_AND_NAVIGATIONBAR_HEIGHT
#define STATUSBAR_AND_NAVIGATIONBAR_HEIGHT (STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT)
#endif

// Tabbar safe bottom margin.
#ifndef SAFE_BOTTOM_MARGIN
#define SAFE_BOTTOM_MARGIN (IPHONE_X_SERIES ? 34.0f : 0.0f)
#endif

// 一个像素的宽度
#ifndef ONE_PIXEL
#define ONE_PIXEL [UIScreen onePixel]
#endif

// 传入宽高进行比较
#ifndef SCREEN_EQUAL
#define SCREEN_EQUAL(_width_, _height_) (CGSizeEqualToSize(CGSizeMake(_width_, _height_), [UIScreen mainScreen].currentMode.size) || CGSizeEqualToSize(CGSizeMake(_height_, _width_), [UIScreen mainScreen].currentMode.size))
#endif

@interface UIScreen (YPKit)

// 返回一个像素的宽度
+ (CGFloat)onePixel;

// 返回状态栏高度
+ (CGFloat)statusBarHeight;

@end
