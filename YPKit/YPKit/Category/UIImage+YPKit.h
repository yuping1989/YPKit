//
//  UIImage+YPKit.h
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-3-24.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YPKit)
/**
 *  根据颜色值生成UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 *  根据颜色值生成UIImage
 *
 *  @param size  生成UIImage的size
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  从中间拉升图像
 */
+ (UIImage *)stretchableImageNamed:(NSString *)name;
/**
 *  拉升图像
 *
 *  @param leftCapWidth 横向拉升，复制的像素位置
 *  @param topCapHeight 竖向拉升，复制的像素位置
 *
 */
+ (UIImage *)stretchableImageNamed:(NSString *)name
                      leftCapWidth:(NSInteger)leftCapWidth
                      topCapHeight:(NSInteger)topCapHeight;
/**
 *  保持比例，放大或者缩小UIImage
 *
 *  @param width 放大或者缩小后的宽度
 *
 */
- (UIImage *)scaleByWidth:(CGFloat)width;

/**
 *  保持比例，放大或者缩小UIImage
 *
 *  @param height 放大或者缩小后的高度
 *
 */
- (UIImage *)scaleByHeight:(CGFloat)height;

/**
 *  修正UIImage的方向
 *
 */
- (UIImage *)fixOrientation;

@end
