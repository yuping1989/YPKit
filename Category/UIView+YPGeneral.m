//
//  UIView+UIViewEXT.m
//  CanXinTong
//
//  Created by 喻平 on 13-2-28.
//  Copyright (c) 2013年 喻平. All rights reserved.
//

#import "UIView+YPGeneral.h"
#define LINE_COLOR rgb(220, 220, 220).CGColor
@implementation UIView (YPGeneral)
- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}
- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (CGFloat)height
{
    return self.frame.size.height;
}
- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (void)centerInHorizontal:(UIView *)parentView
{
    [self setX:(parentView.width - self.width) / 2];
}

- (void)centerInVertical:(UIView *)parentView
{
    [self setY:(parentView.height - self.height) / 2];
}


- (void)addSubLayerWithFrame:(CGRect)frame color:(CGColorRef)colorRef
{
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = colorRef;
    [self.layer addSublayer:layer];
}
- (void)addTopAndBottomLine
{
    [self addTopAndBottomLineWithHeight:0.5f color:LINE_COLOR];
}
- (void)addTopAndBottomLineWithHeight:(float)height color:(CGColorRef)colorRef
{
    [self addSubLayerWithFrame:CGRectMake(0, 0, self.width, height) color:colorRef];
    [self addSubLayerWithFrame:CGRectMake(0, self.height - height, self.width, 0.5f) color:colorRef];
}

- (void)addTopFillLine
{
    [self addSubLayerWithFrame:CGRectMake(0, 0, self.width, 0.5f) color:LINE_COLOR];
}

- (void)addBottomFillLine
{
    [self addSubLayerWithFrame:CGRectMake(0,
                                          self.height - 0.5f,
                                          self.width,
                                          0.5f)
                         color:LINE_COLOR];
}

- (void)setTarget:(id)target action:(SEL)action
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:recognizer];
}
@end
