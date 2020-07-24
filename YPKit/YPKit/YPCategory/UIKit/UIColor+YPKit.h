//
//  UIColor+YPKit.h
//  YPKit
//
//  Created by 喻平 on 16/6/23.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 返回UIColor对象，示例：UIColorRGB(255, 255, 255)。
 */
#define UIColorRGB(_red_, _green_, _blue_) UIColorRGBA(_red_, _green_, _blue_, 1.0f)

/**
 返回UIColor对象，示例：UIColorRGBA(255, 255, 255, 0.8f)。
 */
#define UIColorRGBA(_red_, _green_, _blue_, _alpha_) \
        [UIColor colorWithRed:_red_/255.0f green:_green_/255.0f blue:_blue_/255.0f alpha:_alpha_]

@interface UIColor (YPKit)

/**
 使用hex值生成UIColor对象，无alpha。
 
 @param rgbValue hex值，示例：0x88ffaa
 */
+ (UIColor *)colorWithRGB:(uint32_t)rgbValue;

/**
 使用hex值生成UIColor对象，有alpha。
 
 @param rgbaValue hex值，示例：0x88ffaaff
 */
+ (UIColor *)colorWithRGBA:(uint32_t)rgbaValue;

/**
 使用hex值生成UIColor对象，有alpha。
 
 @param rgbValue hex值，示例：0x88ffaa
 @param alpha alpha值，范围：0.0 ~ 1.0
 */
+ (UIColor *)colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

/**
 返回UIColor的hex值，示例：0x66ccff。
 */
- (uint32_t)rgbValue;

/**
 使用hex字符串生成UIColor对象。
 格式：#RGB #RGBA #RRGGBB #RRGGBBAA 0xRGB RGB，
      `#` or "0x"不是必需，忽略大小写。
 @param hexStr hex字符串，示例: @"0xF0F", @"88ffaa", @"#88ffaaee"
 */
+ (nullable UIColor *)yp_colorWithHexString:(NSString *)hexStr;

/**
 生成hex字符串，无alpha，示例：@"88ffaa"。
 */
- (nullable NSString *)hexString;

/**
 生成hex字符串，有alpha，示例：@"88ffaaff"。
 */
- (nullable NSString *)hexStringWithAlpha;

/**
 Returns the rgba value in hex.
 
 @return hex value of RGBA,such as 0x66ccffff.
 */
- (uint32_t)rgbaValue;

@end

NS_ASSUME_NONNULL_END
