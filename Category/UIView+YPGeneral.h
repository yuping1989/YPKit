//
//  UIView+UIViewEXT.h
//  CanXinTong
//
//  Created by 喻平 on 13-2-28.
//  Copyright (c) 2013年 喻平. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LINE_COLOR rgb(198, 200, 199).CGColor
#define LINE_VIEW_COLOR rgb(198, 200, 199)
@interface UIView (YPGeneral)
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

- (void)setSize:(CGSize)size;

- (CGFloat)height;
- (CGFloat)width;
- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)maxY;
- (CGFloat)maxX;
- (void)horizontalCenterWithWidth:(CGFloat)width;
- (void)verticalCenterWithHeight:(CGFloat)height;
- (void)verticalCenterInSuperView;
- (void)horizontalCenterInSuperView;

- (void)setBoarderWith:(CGFloat)width color:(CGColorRef)color;
- (void)setCornerRadius:(CGFloat)radius;

- (CALayer *)addSubLayerWithFrame:(CGRect)frame color:(CGColorRef)colorRef;
- (void)addTopAndBottomLine;
- (void)addTopAndBottomLineWithColor:(CGColorRef)color;
- (void)addTopAndBottomLineWithHeight:(float)height color:(CGColorRef)colorRef;
- (CALayer *)addTopFillLine;
- (CALayer *)addTopFillLineWithColor:(CGColorRef)color;
- (CALayer *)addBottomFillLine;
- (CALayer *)addBottomFillLineWithColor:(CGColorRef)color;

- (void)setTarget:(id)target action:(SEL)action;

- (UIImage *)capture;
- (UIView *)addTopLineView;
- (UIView *)addTopLineViewPaddingLeft:(CGFloat)left color:(UIColor *)color;
- (UIView *)addBottomLineView;
- (UIView *)addBottomLineViewPaddingLeft:(CGFloat)left color:(UIColor *)color;
@end
