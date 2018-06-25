//
//  UIView+UIViewEXT.m
//  CanXinTong
//
//  Created by 喻平 on 13-2-28.
//  Copyright (c) 2013年 喻平. All rights reserved.
//

#import "UIView+YPKit.h"
#import "UIGestureRecognizer+YPKit.h"
#import "UIScreen+YPKit.h"
#import <objc/runtime.h>

@implementation UIView (YPKit)

#pragma mark - Init

+ (instancetype)viewWithNibName:(NSString *)name {
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject];
}

+ (instancetype)viewFromNib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

#pragma mark - Frame

- (CGFloat)yp_x {
    return self.frame.origin.x;
}
- (void)setYp_x:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)yp_y {
    return self.frame.origin.y;
}

- (void)setYp_y:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)yp_width {
    return self.frame.size.width;
}

- (void)setYp_width:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)yp_height {
    return self.frame.size.height;
}

- (void)setYp_height:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (void)setYp_centerX:(CGFloat)yp_centerX{
    CGPoint center = self.center;
    center.x = yp_centerX;
    self.center = center;
}

- (CGFloat)yp_centerX{
    return self.center.x;
}

- (void)setYp_centerY:(CGFloat)yp_centerY{
    CGPoint center = self.center;
    center.y = yp_centerY;
    self.center = center;
}

- (CGFloat)yp_centerY{
    return self.center.y;
}

- (CGPoint)yp_origin {
    return self.frame.origin;
}

- (void)setYp_origin:(CGPoint)origin {
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

- (CGSize)yp_size {
    return self.frame.size;
}

- (void)setYp_size:(CGSize)size {
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGFloat)yp_maxY {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)yp_maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)horizontalCenterWithWidth:(CGFloat)width {
    self.yp_x = ceilf((width - self.yp_width) / 2);
}

- (void)verticalCenterWithHeight:(CGFloat)height {
    self.yp_y = ceilf((height - self.yp_height) / 2);
}

- (void)verticalCenterInSuperView {
    [self verticalCenterWithHeight:self.superview.yp_height];
}

- (void)horizontalCenterInSuperView {
    [self horizontalCenterWithWidth:self.superview.yp_width];
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

#pragma mark - Line

- (UIView *)addLine:(YPViewLine)type color:(UIColor *)color {
    return [self addLine:type paddingLead:0 paddingTrail:0 thickness:ONE_PIXEL color:color];
}

- (UIView *)addLine:(YPViewLine)type
        paddingLead:(CGFloat)paddingLead
       paddingTrail:(CGFloat)paddingTrail
          thickness:(CGFloat)thickness
              color:(UIColor *)color {
    
    UIView *line = [self lineForType:type];
    if (!line) {
        line = [[UIView alloc] init];
        line.tag = NSIntegerMax - type;
        [self addSubview:line];
    }
    
    switch (type) {
        case YPViewLineTypeTop:
            line.frame = CGRectMake(paddingLead,
                                    0,
                                    self.bounds.size.width - paddingLead - paddingTrail,
                                    thickness);
            line.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
            break;
        case YPViewLineTypeLeft:
            line.frame = CGRectMake(0,
                                    paddingLead,
                                    thickness,
                                    self.bounds.size.height - paddingLead - paddingTrail);
            line.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            break;
        case YPViewLineTypeBottom:
            line.frame = CGRectMake(paddingLead,
                                    self.bounds.size.height - thickness,
                                    self.bounds.size.width - paddingLead - paddingTrail,
                                    thickness);
            line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            break;
        case YPViewLineTypeRight:
            line.frame = CGRectMake(self.bounds.size.width - thickness,
                                    paddingLead,
                                    thickness,
                                    self.bounds.size.height - paddingLead - paddingTrail);
            line.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            break;
            
        default:
            break;
    }
    line.backgroundColor = color;
    
    return line;
}

- (UIView *)lineForType:(YPViewLine)type {
    return [self viewWithTag:NSIntegerMax - type];
}

- (CALayer *)addSubLayerWithFrame:(CGRect)frame color:(UIColor *)color {
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
    return layer;
}

#pragma mark - Others

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

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

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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

@end
