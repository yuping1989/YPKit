//
//  UIView+UIViewEXT.h
//  CanXinTong
//
//  Created by 喻平 on 13-2-28.
//  Copyright (c) 2013年 喻平. All rights reserved.
//

#import <UIKit/UIKit.h>

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
- (void)centerInHorizontal:(UIView *)parentView;
- (void)centerInVertical:(UIView *)parentView;

- (void)addSubLayerWithFrame:(CGRect)frame color:(CGColorRef)colorRef;
- (void)addTopAndBottomLine;
- (void)addTopAndBottomLineWithHeight:(float)height color:(CGColorRef)colorRef;
- (void)addTopFillLine;
- (void)addBottomFillLine;

- (void)setTarget:(id)target action:(SEL)action;
@end
