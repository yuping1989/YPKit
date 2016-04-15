//
//  UIView+UIViewEXT.m
//  CanXinTong
//
//  Created by 喻平 on 13-2-28.
//  Copyright (c) 2013年 喻平. All rights reserved.
//

#import "UIView+YPKit.h"

#define TIPS_IMAGE_VIEW_TAG 10000
#define TIPS_LABEL_TAG 10001

@implementation UIView (YPKit)

+ (instancetype)viewWithNibName:(NSString *)name {
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject];
}

- (void)setClickedHanlder:(YPCompletionBlock)clickedHanlder {
    objc_setAssociatedObject(self, @selector(clickedHanlder), clickedHanlder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YPCompletionBlock)clickedHanlder
{
    return objc_getAssociatedObject(self, _cmd);
}

- (CALayer *)topLineLayer {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTopLineLayer:(CALayer *)topLineLayer {
    objc_setAssociatedObject(self, @selector(topLineLayer), topLineLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)bottomLineLayer {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBottomLineLayer:(CALayer *)bottomLineLayer {
    objc_setAssociatedObject(self, @selector(bottomLineLayer), bottomLineLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

- (void)setTopFillLineWithColor:(UIColor *)color
{
    [self setTopLineWithColor:color paddingLeft:0];
}
- (void)setTopLineWithColor:(UIColor *)color paddingLeft:(float)paddingLeft {
    if (self.topLineLayer) {
        [self.topLineLayer removeFromSuperlayer];
        self.topLineLayer = nil;
    }
    self.topLineLayer = [self addSubLayerWithFrame:CGRectMake(paddingLeft,
                                                              0,
                                                              SCREEN_WIDTH - paddingLeft,
                                                              ONE_PIXEL)
                                             color:color];
}

- (void)setBottomFillLineWithColor:(UIColor *)color
{
    [self setBottomLineWithColor:color paddingLeft:0];
}

- (void)setBottomLineWithColor:(UIColor *)color paddingLeft:(float)paddingLeft {
    if (self.bottomLineLayer) {
        [self.bottomLineLayer removeFromSuperlayer];
        self.bottomLineLayer = nil;
    }
    self.bottomLineLayer = [self addSubLayerWithFrame:CGRectMake(paddingLeft,
                                                                 self.height - ONE_PIXEL,
                                                                 SCREEN_WIDTH - paddingLeft,
                                                                 ONE_PIXEL)
                                                color:color];
}

- (void)setTopAndBottomLineWithColor:(UIColor *)color {
    [self setTopFillLineWithColor:color];
    [self setBottomFillLineWithColor:color];
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


- (UIView *)setTopLineViewWithColor:(UIColor *)color paddingLeft:(CGFloat)left
{
    __block UIView *blockSelf = self;
    return [self addSubviewWithColor:color constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.right.equalTo(blockSelf);
        make.height.equalTo(@(ONE_PIXEL));
        make.top.equalTo(blockSelf);
    }];
}

- (UIView *)setBottomLineViewWithColor:(UIColor *)color paddingLeft:(CGFloat)left
{
    __block UIView *blockSelf = self;
    return [self addSubviewWithColor:color constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.right.equalTo(blockSelf);
        make.height.equalTo(@(ONE_PIXEL));
        make.bottom.equalTo(blockSelf);
    }];
}

- (UIView *)addSubviewWithColor:(UIColor *)color
                    constraints:(void(^)(MASConstraintMaker *make))block  {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = color;
    [self addSubview:line];
    [line mas_makeConstraints:block];
    return line;
}

- (void)setTipsViewWithImageName:(NSString *)imageName
                            text:(NSString *)text
                       textColor:(UIColor *)textColor {
    UIImageView *imageView = [self viewWithTag:TIPS_IMAGE_VIEW_TAG];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    }
    imageView.center = CGPointMake(self.width / 2, self.height / 2 - 40);
    imageView.contentMode = UIViewContentModeCenter;
    imageView.tag = TIPS_IMAGE_VIEW_TAG;
    [self addSubview:imageView];
    NSLog(@"self--->%@", NSStringFromCGRect(self.frame));
    NSLog(@"image frame--->%@", NSStringFromCGRect(imageView.frame));
    
    UILabel *label = [self viewWithTag:TIPS_LABEL_TAG];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.maxY + 10, SCREEN_WIDTH, 20)];
    }
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = textColor;
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.tag = TIPS_LABEL_TAG;
    [self addSubview:label];
}

- (void)removeTipsView {
    [[self viewWithTag:TIPS_IMAGE_VIEW_TAG] removeFromSuperview];
    [[self viewWithTag:TIPS_LABEL_TAG] removeFromSuperview];
}
@end
