//
//  UIImage+YPKit.h
//  YPKit
//
//  Created by 喻平 on 14-3-24.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YPKit)

/**
 *  从中间拉升图像
 */
+ (nullable UIImage *)stretchableImageNamed:(NSString *)name;

/**
 *  拉升图像
 *
 *  @param leftCapWidth 横向拉升，复制的像素位置
 *  @param topCapHeight 竖向拉升，复制的像素位置
 *
 */
+ (nullable UIImage *)stretchableImageNamed:(NSString *)name
                               leftCapWidth:(NSInteger)leftCapWidth
                               topCapHeight:(NSInteger)topCapHeight;

/**
 *  根据颜色值生成UIImage
 */
+ (nullable UIImage *)imageWithColor:(UIColor *)color;

/**
 *  根据颜色值生成UIImage
 *
 *  @param size  生成UIImage的size
 */
+ (nullable UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  保持比例，放大或者缩小UIImage
 *
 *  @param width 放大或者缩小后的宽度
 *
 */
- (nullable UIImage *)scaledImageByWidth:(CGFloat)width;

/**
 *  保持比例，放大或者缩小UIImage
 *
 *  @param height 放大或者缩小后的高度
 *
 */
- (nullable UIImage *)scaledImageByHeight:(CGFloat)height;

/**
 *  修正UIImage的方向
 *
 */
- (nullable UIImage *)imageByFixOrientation;

/**
 Returns a grayscaled image.
 */
- (nullable UIImage *)imageByGrayscale;

/**
 Applies a blur effect to this image. Suitable for blur any content.
 */
- (nullable UIImage *)imageByBlurSoft;

/**
 Applies a blur effect to this image. Suitable for blur any content except pure white.
 (same as iOS Control Panel)
 */
- (nullable UIImage *)imageByBlurLight;

/**
 Applies a blur effect to this image. Suitable for displaying black text.
 (same as iOS Navigation Bar White)
 */
- (nullable UIImage *)imageByBlurExtraLight;

/**
 Applies a blur effect to this image. Suitable for displaying white text.
 (same as iOS Notification Center)
 */
- (nullable UIImage *)imageByBlurDark;

/**
 Applies a blur and tint color to this image.
 
 @param tintColor  The tint color.
 */
- (nullable UIImage *)imageByBlurWithTint:(UIColor *)tintColor;

/**
 Applies a blur, tint color, and saturation adjustment to this image,
 optionally within the area specified by @a maskImage.
 
 @param blurRadius     The radius of the blur in points, 0 means no blur effect.
 
 @param tintColor      An optional UIColor object that is uniformly blended with
 the result of the blur and saturation operations. The
 alpha channel of this color determines how strong the
 tint is. nil means no tint.
 
 @param tintBlendMode  The @a tintColor blend mode. Default is kCGBlendModeNormal (0).
 
 @param saturation     A value of 1.0 produces no change in the resulting image.
 Values less than 1.0 will desaturation the resulting image
 while values greater than 1.0 will have the opposite effect.
 0 means gray scale.
 
 @param maskImage      If specified, @a inputImage is only modified in the area(s)
 defined by this mask.  This must be an image mask or it
 must meet the requirements of the mask parameter of
 CGContextClipToMask.
 
 @return               image with effect, or nil if an error occurs (e.g. no
 enough memory).
 */
- (nullable UIImage *)imageByBlurRadius:(CGFloat)blurRadius
                              tintColor:(nullable UIColor *)tintColor
                               tintMode:(CGBlendMode)tintBlendMode
                             saturation:(CGFloat)saturation
                              maskImage:(nullable UIImage *)maskImage;

@end

NS_ASSUME_NONNULL_END
