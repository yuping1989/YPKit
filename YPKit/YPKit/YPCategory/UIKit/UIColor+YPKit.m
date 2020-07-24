//
//  UIColor+YPKit.m
//  YPKit
//
//  Created by 喻平 on 16/6/23.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import "UIColor+YPKit.h"

@interface NSString (SAMPrivateAdditions)
- (NSUInteger)yp_hexValue;
@end

@implementation NSString (SAMPrivateAdditions)
- (NSUInteger)yp_hexValue {
    NSUInteger result = 0;
    sscanf([self UTF8String], "%lx", (unsigned long *)&result);
    return result;
}
@end

@implementation UIColor (YPKit)

+ (UIColor *)colorWithRGB:(uint32_t)rgbValue {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:1];
}

+ (UIColor *)colorWithRGBA:(uint32_t)rgbaValue {
    return [UIColor colorWithRed:((rgbaValue & 0xFF000000) >> 24) / 255.0f
                           green:((rgbaValue & 0xFF0000) >> 16) / 255.0f
                            blue:((rgbaValue & 0xFF00) >> 8) / 255.0f
                           alpha:(rgbaValue & 0xFF) / 255.0f];
}

+ (UIColor *)colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:alpha];
}

- (uint32_t)rgbValue {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    int8_t red = r * 255;
    uint8_t green = g * 255;
    uint8_t blue = b * 255;
    return (red << 16) + (green << 8) + blue;
}

- (uint32_t)rgbaValue {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    int8_t red = r * 255;
    uint8_t green = g * 255;
    uint8_t blue = b * 255;
    uint8_t alpha = a * 255;
    return (red << 24) + (green << 16) + (blue << 8) + alpha;
}

+ (instancetype)yp_colorWithHexString:(NSString *)hexStr {
    hexStr = [[hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([hexStr hasPrefix:@"#"]) {
        hexStr = [hexStr substringFromIndex:1];
    } else if ([hexStr hasPrefix:@"0X"]) {
        hexStr = [hexStr substringFromIndex:2];
    }
    
    NSUInteger length = [hexStr length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return nil;
    }
    
    if (length < 5) {
        NSString *r = [hexStr substringWithRange:NSMakeRange(0, 1)];
        NSString *g = [hexStr substringWithRange:NSMakeRange(1, 1)];
        NSString *b = [hexStr substringWithRange:NSMakeRange(2, 1)];
        NSString *a;
        if (length == 4) {
            a = [hexStr substringWithRange:NSMakeRange(3, 1)];
        } else {
            a = @"F";
        }
        hexStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",
               r, r, g, g, b, b, a, a];
    } else if (length == 6) {
        hexStr = [hexStr stringByAppendingString:@"FF"];
    }
    
    CGFloat red = [[hexStr substringWithRange:NSMakeRange(0, 2)] yp_hexValue] / 255.0f;
    CGFloat green = [[hexStr substringWithRange:NSMakeRange(2, 2)] yp_hexValue] / 255.0f;
    CGFloat blue = [[hexStr substringWithRange:NSMakeRange(4, 2)] yp_hexValue] / 255.0f;
    CGFloat alpha = [[hexStr substringWithRange:NSMakeRange(6, 2)] yp_hexValue] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (NSString *)hexString {
    return [self hexStringWithAlpha:NO];
}

- (NSString *)hexStringWithAlpha {
    return [self hexStringWithAlpha:YES];
}

- (NSString *)hexStringWithAlpha:(BOOL)withAlpha {
    CGColorRef color = self.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    static NSString *stringFormat = @"%02x%02x%02x";
    NSString *hex = nil;
    if (count == 2) {
        NSUInteger white = (NSUInteger)(components[0] * 255.0f);
        hex = [NSString stringWithFormat:stringFormat, white, white, white];
    } else if (count == 4) {
        hex = [NSString stringWithFormat:stringFormat,
               (NSUInteger)(components[0] * 255.0f),
               (NSUInteger)(components[1] * 255.0f),
               (NSUInteger)(components[2] * 255.0f)];
    }
    
    if (hex && withAlpha) {
        hex = [hex stringByAppendingFormat:@"%02lx",
               (unsigned long)(CGColorGetAlpha(self.CGColor) * 255.0 + 0.5)];
    }
    return hex;
}

@end
