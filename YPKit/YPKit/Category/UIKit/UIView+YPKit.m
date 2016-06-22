//
//  UIView+UIViewEXT.m
//  CanXinTong
//
//  Created by 喻平 on 13-2-28.
//  Copyright (c) 2013年 喻平. All rights reserved.
//

#import "UIView+YPKit.h"
#import "UIGestureRecognizer+YPKit.h"

#define TIPS_IMAGE_VIEW_TAG 10000
#define TIPS_LABEL_TAG 10001


@implementation UIView (YPKit)

#pragma mark - Init

+ (instancetype)viewWithNibName:(NSString *)name {
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject];
}

+ (instancetype)viewFromNib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

#pragma mark - Frame

- (CGFloat)x {
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)horizontalCenterWithWidth:(CGFloat)width {
    self.x = ceilf((width - self.width) / 2);
}

- (void)verticalCenterWithHeight:(CGFloat)height {
    self.y = ceilf((height - self.height) / 2);
}

- (void)verticalCenterInSuperView {
    [self verticalCenterWithHeight:self.superview.height];
}

- (void)horizontalCenterInSuperView {
    [self horizontalCenterWithWidth:self.superview.width];
}

#pragma mark - Tap Gesture

- (UITapGestureRecognizer *)addSingleTapGestureWithBlock:(void (^)(UITapGestureRecognizer *))block {
    return [self addTapGestureWithNumberOfTapsRequired:1 block:block];
}

- (UITapGestureRecognizer *)addDoubleTapGestureWithBlock:(void (^)(UITapGestureRecognizer *))block {
    return [self addTapGestureWithNumberOfTapsRequired:2 block:block];
}

- (UITapGestureRecognizer *)addTapGestureWithNumberOfTapsRequired:(NSUInteger)numberOfTapsRequired
                                                            block:(void (^)(UITapGestureRecognizer *))block {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithActionBlock:block];
    recognizer.numberOfTapsRequired = numberOfTapsRequired;
    [self addGestureRecognizer:recognizer];
    return recognizer;
}

- (UITapGestureRecognizer *)setSingleTapGestureWithBlock:(void (^)(UITapGestureRecognizer *))block {
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {
            [self removeGestureRecognizer:obj];
        }
    }];
    return [self addTapGestureWithNumberOfTapsRequired:1 block:block];
}

- (UITapGestureRecognizer *)setSingleTapGestureTarget:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {
            [self removeGestureRecognizer:obj];
        }
    }];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:recognizer];
    return recognizer;
}

#pragma mark - Top and bottom line

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

- (CALayer *)addSubLayerWithFrame:(CGRect)frame color:(UIColor *)color {
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
    return layer;
}

- (void)setTopFillLineWithColor:(UIColor *)color {
    [self setTopLineWithColor:color paddingLeft:0];
}

- (void)setTopLineWithColor:(UIColor *)color paddingLeft:(CGFloat)paddingLeft {
    CGRect frame = CGRectMake(paddingLeft,
                              0,
                              SCREEN_WIDTH - paddingLeft,
                              ONE_PIXEL);
    if (!self.topLineLayer) {
        self.topLineLayer = [self addSubLayerWithFrame:frame color:color];
    } else {
        self.topLineLayer.frame = frame;
        self.topLineLayer.backgroundColor = color.CGColor;
    }
}

- (void)setBottomFillLineWithColor:(UIColor *)color {
    [self setBottomLineWithColor:color paddingLeft:0];
}

- (void)setBottomLineWithColor:(UIColor *)color paddingLeft:(CGFloat)paddingLeft {
    CGRect frame = CGRectMake(paddingLeft,
                              self.height - ONE_PIXEL,
                              SCREEN_WIDTH - paddingLeft,
                              ONE_PIXEL);
    if (!self.bottomLineLayer) {
        self.bottomLineLayer = [self addSubLayerWithFrame:frame color:color];
    } else {
        self.bottomLineLayer.frame = frame;
        self.bottomLineLayer.backgroundColor = color.CGColor;
    }
    
}

- (void)setTopAndBottomLineWithColor:(UIColor *)color {
    [self setTopFillLineWithColor:color];
    [self setBottomFillLineWithColor:color];
}

- (UIView *)setTopLineViewWithColor:(UIColor *)color paddingLeft:(CGFloat)left {
    __weak UIView *weakSelf = self;
    return [self addSubviewWithColor:color constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.right.equalTo(weakSelf);
        make.height.equalTo(@(ONE_PIXEL));
        make.top.equalTo(weakSelf);
    }];
}

- (UIView *)setBottomLineViewWithColor:(UIColor *)color paddingLeft:(CGFloat)left {
    __weak UIView *weakSelf = self;
    return [self addSubviewWithColor:color constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.right.equalTo(weakSelf);
        make.height.equalTo(@(ONE_PIXEL));
        make.bottom.equalTo(weakSelf);
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

#pragma mark - Others

- (NSIndexPath *)indexPath {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self, @selector(indexPath), indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBoarderWith:(CGFloat)width color:(UIColor *)color {
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}
- (void)setCornerRadius:(CGFloat)radius {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = radius;
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

- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (NSData *)snapshotPDF {
    CGRect bounds = self.bounds;
    NSMutableData *data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

#pragma mark - Methods should be deprecated

- (void)setClickedHandler:(YPCompletionBlock)clickedHandler {
    objc_setAssociatedObject(self, @selector(clickedHandler), clickedHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YPCompletionBlock)clickedHandler{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOnClickedHandler:(YPCompletionBlock)clickedHandler {
    self.clickedHandler = clickedHandler;
    [self setTapGestureTarget:self action:@selector(handleSingleTap)];
}

- (void)setTapGestureTarget:(id)target action:(SEL)action
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    recognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:recognizer];
}




- (void)handleSingleTap {
    if (self.clickedHandler) {
        self.clickedHandler();
    }
}

@end
