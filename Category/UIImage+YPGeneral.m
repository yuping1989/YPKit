//
//  UIImage+YPGeneral.m
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-3-24.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import "UIImage+YPGeneral.h"

@implementation UIImage (YPGeneral)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIImage *)scaleByWidth:(CGFloat)width;
{
    UIGraphicsBeginImageContext(CGSizeMake(width, self.size.height * width / self.size.width));
    [self drawInRect:CGRectMake(0, 0, width, self.size.height * width / self.size.width)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
- (UIImage *)scaleByHeight:(CGFloat)height;
{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * height / self.size.height, height));
    [self drawInRect:CGRectMake(0, 0, self.size.width * height / self.size.height, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
@end
