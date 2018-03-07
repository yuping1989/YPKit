//
//  UIColor+YPKit.h
//  YPKit
//
//  Created by 喻平 on 16/6/23.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  返回UIColor对象，示例：UIColorRGB(255, 255, 255)
 */
#define UIColorRGB(_red_, _green_, _blue_) UIColorRGBA(_red_, _green_, _blue_, 1.0f)

/**
 *  返回UIColor对象，示例：UIColorRGBA(255, 255, 255, 0.8f)
 */
#define UIColorRGBA(_red_, _green_, _blue_, _alpha_) \
        [UIColor colorWithRed:_red_/255.0f green:_green_/255.0f blue:_blue_/255.0f alpha:_alpha_]

@interface UIColor (YPKit)

/**
 Creates and returns a color object using the hex RGB color values.
 
 @param rgbValue  The rgb value such as 0x66ccff.
 
 @return          The color object. The color information represented by this
 object is in the device RGB colorspace.
 */
+ (UIColor *)colorWithRGB:(uint32_t)rgbValue;

/**
 Creates and returns a color object using the hex RGBA color values.
 
 @param rgbaValue  The rgb value such as 0x66ccffff.
 
 @return           The color object. The color information represented by this
 object is in the device RGB colorspace.
 */
+ (UIColor *)colorWithRGBA:(uint32_t)rgbaValue;

/**
 Creates and returns a color object using the specified opacity and RGB hex value.
 
 @param rgbValue  The rgb value such as 0x66CCFF.
 
 @param alpha     The opacity value of the color object,
 specified as a value from 0.0 to 1.0.
 
 @return          The color object. The color information represented by this
 object is in the device RGB colorspace.
 */
+ (UIColor *)colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

/**
 Returns the rgb value in hex.
 @return hex value of RGB,such as 0x66ccff.
 */
- (uint32_t)rgbValue;

/**
 Returns the rgba value in hex.
 
 @return hex value of RGBA,such as 0x66ccffff.
 */
- (uint32_t)rgbaValue;

@end
