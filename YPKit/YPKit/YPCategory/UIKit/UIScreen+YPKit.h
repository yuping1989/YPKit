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

#ifndef IPHONE_X
#define IPHONE_X ((SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f) || (SCREEN_WIDTH == 812.f && SCREEN_HEIGHT == 375.f))
#endif

// Status bar height.
#ifndef STATUSBAR_HEIGHT
#define STATUSBAR_HEIGHT (IPHONE_X ? 44.f : 20.f)
#endif

// Navigation bar height.
#ifndef NAVIGATIONBAR_HEIGHT
#define NAVIGATIONBAR_HEIGHT 44.f
#endif

// Status bar & navigation bar height.
#ifndef STATUSBAR_AND_NAVIGATIONBAR_HEIGHT
#define STATUSBAR_AND_NAVIGATIONBAR_HEIGHT (IPHONE_X ? 88.f : 64.f)
#endif

// Tabbar safe bottom margin.
#ifndef SAFE_BOTTOM_MARGIN
#define SAFE_BOTTOM_MARGIN (IPHONE_X ? 34.f : 0.0f)
#endif

// 一个像素的宽度
#ifndef ONE_PIXEL
#define ONE_PIXEL [UIScreen onePixel]
#endif
@interface UIScreen (YPKit)

// 返回一个像素的宽度
+ (CGFloat)onePixel;

@end
