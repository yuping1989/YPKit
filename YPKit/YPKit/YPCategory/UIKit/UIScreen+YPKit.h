//
//  UIScreen+YPKit.h
//  YPKit
//
//  Created by 喻平 on 16/6/23.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#endif

// iPhone X
#define YP_IPHONE_X ((YP_SCREEN_WIDTH == 375.f && YP_SCREEN_HEIGHT == 812.f) || (YP_SCREEN_WIDTH == 812.f && YP_SCREEN_HEIGHT == 375.f))

// Status bar height.
#define YP_STATUSBAR_HEIGHT (YP_IPHONE_X ? 44.f : 20.f)

// Navigation bar height.
#define YP_NAVIGATIONBAR_HEIGHT 44.f

// Status bar & navigation bar height.
#define YP_STATUSBAR_AND_NAVIGATIONBAR_HEIGHT (IPHONE_X ? 88.f : 64.f)

// Tabbar safe bottom margin.
#define YP_SAFE_BOTTOM_MARGIN (IPHONE_X ? 34.f : 0.0f)

// 一个像素的宽度
#define YP_ONE_PIXEL [UIScreen onePixel]

@interface UIScreen (YPKit)

// 返回一个像素的宽度
+ (CGFloat)onePixel;

@end
