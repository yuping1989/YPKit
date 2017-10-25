//
//  UIScreen+YPKit.h
//  YPKit
//
//  Created by 喻平 on 16/6/23.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 一个像素的宽度
#define ONE_PIXEL [UIScreen onePixel]

@interface UIScreen (YPKit)

// 返回一个像素的宽度
+ (CGFloat)onePixel;

@end
