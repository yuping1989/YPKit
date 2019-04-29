//
//  UIScrollView+YPKit.m
//  MGMobileMusic
//
//  Created by 喻平 on 2016/12/29.
//  Copyright © 2016年 migu. All rights reserved.
//

#import "UIScrollView+YPKit.h"
#import "UIView+YPKit.h"
#import <objc/runtime.h>

static NSString * const kContentOffset = @"contentOffset";

@interface YPScalableHeaderView ()

@property (nonatomic, strong, readwrite) UIImageView *scalableImageView;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, assign) CGFloat defaultHeight;
@property (nonatomic, assign) UIEdgeInsets imageViewInsets;
@property (nonatomic, strong) UIColor *maskColor;

@end

@implementation YPScalableHeaderView

- (instancetype)initWithFrame:(CGRect)frame imageViewInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        _imageViewInsets = insets;
        
        _scalableImageView = [[UIImageView alloc] initWithFrame:[self frameForImageView]];
        _scalableImageView.contentMode = UIViewContentModeScaleAspectFill;
        _scalableImageView.clipsToBounds = YES;
        [self addSubview:_scalableImageView];
    }
    
    return self;
}

- (void)setCustomView:(UIView *)customView {
    [_customView removeFromSuperview];
    _customView = customView;
    _customView.frame = self.bounds;
    _customView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:customView];
}

- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    if (!_maskColor && self.maskView) {
        [self.maskView removeFromSuperview];
        self.maskView = nil;
        return;
    }
    if (!self.maskView) {
        self.maskView = [[UIView alloc] initWithFrame:self.bounds];
        self.maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.scalableImageView addSubview:self.maskView];
    }
    self.maskView.backgroundColor = maskColor;
}

- (CGRect)frameForImageView {
    return CGRectMake(self.imageViewInsets.left, self.imageViewInsets.top, self.frame.size.width - self.imageViewInsets.left - self.imageViewInsets.right, self.frame.size.height - self.imageViewInsets.top - self.imageViewInsets.bottom);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    if (![scrollView isKindOfClass:[UIScrollView class]]) {
        return;
    }
    CGFloat insetTop = scrollView.contentInset.top;
    CGFloat offsetY = scrollView.contentOffset.y + insetTop;
    if (offsetY < 0) {
        CGFloat height = self.defaultHeight - offsetY;
        self.frame = CGRectMake(0, offsetY - insetTop, self.frame.size.width, height);
        self.scalableImageView.frame = CGRectMake(offsetY + self.imageViewInsets.left, self.imageViewInsets.top, self.frame.size.width - self.imageViewInsets.left - self.imageViewInsets.right - offsetY * 2, height - self.imageViewInsets.top - self.imageViewInsets.bottom);
    } else {
        self.frame = CGRectMake(0, -insetTop, self.frame.size.width, self.defaultHeight);
        self.scalableImageView.frame = [self frameForImageView];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self setNeedsLayout];
}

@end


@interface UIScrollView ()

@property (nonatomic, strong, readwrite) YPScalableHeaderView *yp_headerView;

@end

@implementation UIScrollView (YPKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = NSSelectorFromString(@"dealloc");
        SEL swizzledSelector = @selector(ypKit_dealloc);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)ypKit_dealloc {
    if (self.yp_headerView) {
        [self removeObserver:self.yp_headerView forKeyPath:kContentOffset];
    }
    [self ypKit_dealloc];
}

- (void)setScalableHeaderWithImage:(UIImage *)image
                     defaultHeight:(CGFloat)height
                         maskColor:(UIColor *)maskColor {
    [self setScalableHeaderWithImage:image
                       defaultHeight:height
                     imageViewInsets:UIEdgeInsetsZero
                           maskColor:maskColor];
}

- (void)setScalableHeaderWithImage:(UIImage *)image
                     defaultHeight:(CGFloat)height
                   imageViewInsets:(UIEdgeInsets)insets
                         maskColor:(UIColor *)maskColor {
    if (!self.yp_headerView) {
        self.yp_headerView = [[YPScalableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, height) imageViewInsets:insets];
        self.yp_headerView.backgroundColor = [UIColor clearColor];
        self.yp_headerView.autoresizingMask =
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
        
        if ([self isKindOfClass:[UITableView class]]) {
            [(UITableView *)self setTableHeaderView:self.yp_headerView];
        } else {
            [self addSubview:self.yp_headerView];
            [self sendSubviewToBack:self.yp_headerView];
            self.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
            if ([self isMemberOfClass:[UIScrollView class]] &&
                CGPointEqualToPoint(self.contentOffset, CGPointMake(0, 0))) {
                self.contentOffset = CGPointMake(0, -height);
            }
        }
        [self addObserver:self.yp_headerView
               forKeyPath:kContentOffset
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    }
    self.yp_headerView.scalableImageView.image = image;
    self.yp_headerView.defaultHeight = height;
    self.yp_headerView.maskColor = maskColor;
}

- (void)removeScalableHeader {
    if (self.yp_headerView) {
        [self removeObserver:self.yp_headerView forKeyPath:kContentOffset];
        [self.yp_headerView removeFromSuperview];
        self.yp_headerView = nil;
        
        self.contentInset = UIEdgeInsetsZero;
        self.contentOffset = CGPointZero;
    }
}

- (UIImageView *)scalableHeaderImageView {
    return self.yp_headerView.scalableImageView;
}

- (void)setYp_headerView:(YPScalableHeaderView *)headerView {
    objc_setAssociatedObject(self, @selector(yp_headerView), headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YPScalableHeaderView *)yp_headerView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setScalableHeaderCustomView:(UIView *)customView {
    self.yp_headerView.customView = customView;
}

- (UIImage *)contentSnapshotImage {
    if (![self isKindOfClass:[UIScrollView class]]) {
        return [self snapshotImage];
    }
    UIScrollView *scrollView = (UIScrollView *)self;
    
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, self.opaque, 0);
    CGPoint savedContentOffset = scrollView.contentOffset;
    CGRect savedFrame = scrollView.frame;
    scrollView.contentOffset = CGPointZero;
    scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
    
    [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    scrollView.contentOffset = savedContentOffset;
    scrollView.frame = savedFrame;
    UIGraphicsEndImageContext();
    return image;
}

@end
