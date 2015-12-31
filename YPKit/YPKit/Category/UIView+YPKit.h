//
//  UIView+UIViewEXT.h
//  CanXinTong
//
//  Created by 喻平 on 13-2-28.
//  Copyright (c) 2013年 喻平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface UIView (YPKit)
@property (nonatomic, strong) YPCompletionBlock clickedHanlder;
@property (nonatomic, strong) CALayer *topLineLayer;
@property (nonatomic, strong) CALayer *bottomLineLayer;

+ (instancetype)instanceWithOwner:(id)owner;

- (void)setOnClickedHanlder:(YPCompletionBlock)clickedHanlder;

- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

- (void)setSize:(CGSize)size;
- (CGSize)size;
- (void)setOrigin:(CGPoint)point;
- (CGPoint)origin;

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

- (void)setBoarderWith:(CGFloat)width color:(UIColor *)color;
- (void)setCornerRadius:(CGFloat)radius;

- (CALayer *)addSubLayerWithFrame:(CGRect)frame color:(UIColor *)color;
- (void)setTopFillLineWithColor:(UIColor *)color;
- (void)setTopLineWithColor:(UIColor *)color paddingLeft:(float)paddingLeft;
- (void)setBottomFillLineWithColor:(UIColor *)color;
- (void)setBottomLineWithColor:(UIColor *)color paddingLeft:(float)paddingLeft;
- (void)setTopAndBottomLineWithColor:(UIColor *)color;

- (void)setTarget:(id)target action:(SEL)action;

- (UIImage *)capture;
- (UIView *)setTopLineViewWithColor:(UIColor *)color paddingLeft:(CGFloat)left;
- (UIView *)setBottomLineViewWithColor:(UIColor *)color paddingLeft:(CGFloat)left;
- (UIView *)addSubviewWithColor:(UIColor *)color constraints:(void(^)(MASConstraintMaker *make))block;
@end
