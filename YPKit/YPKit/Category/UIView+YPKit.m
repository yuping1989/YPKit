//
//  UIView+UIViewEXT.m
//  CanXinTong
//
//  Created by 喻平 on 13-2-28.
//  Copyright (c) 2013年 喻平. All rights reserved.
//

#import "UIView+YPKit.h"
#define kClickedHanlder @"kClickedHanlder"
@implementation UIView (YPKit)
- (void)setClickedHanlder:(YPCompletionBlock)clickedHanlder {
    objc_setAssociatedObject(self, kClickedHanlder, clickedHanlder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (YPCompletionBlock)clickedHanlder
{
    return objc_getAssociatedObject(self, kClickedHanlder);
}

- (void)setOnClickedHanlder:(YPCompletionBlock)clickedHanlder {
    self.clickedHanlder = clickedHanlder;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapRecognizer];
}

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

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)point
{
    CGRect rect = self.frame;
    rect.origin = point;
    self.frame = rect;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)horizontalCenterWithWidth:(CGFloat)width
{
    [self setX:ceilf((width - self.width) / 2)];
}

- (void)verticalCenterWithHeight:(CGFloat)height
{
    [self setY:ceilf((height - self.height) / 2)];
}
- (void)verticalCenterInSuperView
{
    [self verticalCenterWithHeight:self.superview.height];
}
- (void)horizontalCenterInSuperView
{
    [self horizontalCenterWithWidth:self.superview.width];
}

- (void)setBoarderWith:(CGFloat)width color:(UIColor *)color
{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}
- (void)setCornerRadius:(CGFloat)radius
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (CALayer *)addSubLayerWithFrame:(CGRect)frame color:(UIColor *)color
{
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
    return layer;
}

- (CALayer *)addTopFillLineWithColor:(UIColor *)color
{
    return [self addSubLayerWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5f) color:color];
}

- (CALayer *)addBottomFillLineWithColor:(UIColor *)color
{
    return [self addBottomLineWithColor:color paddingLeft:0];
}

- (CALayer *)addTopLineWithColor:(UIColor *)color paddingLeft:(float)paddingLeft {
    return [self addSubLayerWithFrame:CGRectMake(paddingLeft,
                                                 0,
                                                 SCREEN_WIDTH - paddingLeft,
                                                 0.5f)
                                color:color];
}

- (CALayer *)addBottomLineWithColor:(UIColor *)color paddingLeft:(float)paddingLeft {
    return [self addSubLayerWithFrame:CGRectMake(paddingLeft,
                                                 self.height - 0.5f,
                                                 SCREEN_WIDTH - paddingLeft,
                                                 0.5f)
                                color:color];
}

- (void)addTopAndBottomLineWithColor:(UIColor *)color {
    [self addTopFillLineWithColor:color];
    [self addBottomFillLineWithColor:color];
}

- (void)setTarget:(id)target action:(SEL)action
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:recognizer];
}

- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(270, self.bounds.size.height), self.opaque, 0.0);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


- (void)handleSingleTap {
    if (self.clickedHanlder) {
        self.clickedHanlder();
    }
}

//- (UIView *)addTopLineView
//{
//    return [self addTopLineViewPaddingLeft:0 color:nil];
//}
//- (UIView *)addTopLineViewPaddingLeft:(CGFloat)left color:(UIColor *)color
//{
//    UIView *line = [[UIView alloc] init];
//    line.backgroundColor = color;
//    [self addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@(left));
//        make.right.equalTo(self);
//        make.top.equalTo(self);
//        make.height.equalTo(@0.5f);
//    }];
//    return line;
//}
//- (UIView *)addBottomLineView
//{
//    return [self addBottomLineViewPaddingLeft:0 color:nil];
//}
//- (UIView *)addBottomLineViewPaddingLeft:(CGFloat)left color:(UIColor *)color
//{
//    UIView *line = [[UIView alloc] init];
//    line.backgroundColor = color;
//    [self addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@(left));
//        make.right.equalTo(self);
//        make.bottom.equalTo(self);
//        make.height.equalTo(@0.5f);
//    }];
//    return line;
//}
@end
