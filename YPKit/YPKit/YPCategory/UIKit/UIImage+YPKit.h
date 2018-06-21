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
 *  以imageWithContentsOfFile的方式获取图片。
 *  此方法无法获取*.xcassets文件夹里面的图片
 *
 *  @param name 文件名或相对路径，注意：
 *              如果是png图片，扩展名非必需，示例：image或者image.png均可；
 *              如果是jpg图片，扩展名必需，示例：image.jpg；
 *              如果图片在bundle里面，传入相对路径即可，示例：xxx.bunlde/image.jpg。
 */
+ (nullable UIImage *)imageWithContentsOfFileName:(NSString *)name;

/**
 *  从中间拉伸图像。
 */
+ (nullable UIImage *)stretchableImageNamed:(NSString *)name;

/**
 *  拉升图像。
 *
 *  @param leftCapWidth 横向拉升，复制的像素位置
 *  @param topCapHeight 竖向拉升，复制的像素位置
 *
 */
+ (nullable UIImage *)stretchableImageNamed:(NSString *)name
                               leftCapWidth:(NSInteger)leftCapWidth
                               topCapHeight:(NSInteger)topCapHeight;

/**
 *  根据颜色值生成UIImage。
 */
+ (nullable UIImage *)imageWithColor:(UIColor *)color;

/**
 *  根据颜色值生成UIImage。
 *
 *  @param size  生成UIImage的size
 */
+ (nullable UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  根据字符串生成二维码。
 *
 *  @param string  二维码字符串
 */
+ (nullable UIImage *)imageWithQRCodeString:(NSString *)string size:(CGFloat)size;

/**
 *  生产带圆角的UIImage。
 *
 *  @param radius  圆角值
 */
- (nullable UIImage *)imageWithCornerRadius:(CGFloat)radius;

/**
 *  生产带圆角和边框的UIImage对象。
 *
 *  @param radius       圆角值
 *  @param borderWidth  边框宽度
 *  @param borderColor  边框颜色
 */
- (nullable UIImage *)imageWithCornerRadius:(CGFloat)radius
                                borderWidth:(CGFloat)borderWidth
                                borderColor:(UIColor *)borderColor;
/**
 *  生产带圆角和边框的UIImage对象。
 *
 *  @param radius           圆角值
 *  @param corners          圆角位置
 *  @param borderWidth      边框宽度
 *  @param borderColor      边框颜色
 *  @param borderLineJoin   边框连接类型
 */
- (nullable UIImage *)imageWithCornerRadius:(CGFloat)radius
                                    corners:(UIRectCorner)corners
                                borderWidth:(CGFloat)borderWidth
                                borderColor:(UIColor *)borderColor
                             borderLineJoin:(CGLineJoin)borderLineJoin;

/**
 *  保持比例，根据width调整Image的大小
 *
 *  @param width 调整后的宽度
 */
- (nullable UIImage *)imageByZoomToWidth:(CGFloat)width;

/**
 *  保持比例，根据height调整Image的大小
 *
 *  @param height 调整后的高度
 */
- (nullable UIImage *)imageByZoomToHeight:(CGFloat)height;

/**
 *  调整图片的size
 *
 *  @param size 调整后的size
 */
- (nullable UIImage *)imageByResizeToSize:(CGSize)size;

/**
 *  裁剪Image
 *
 *  @param rect 裁剪位置和大小
 */
- (nullable UIImage *)imageByCropToRect:(CGRect)rect;

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
