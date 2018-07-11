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

@interface _YPScalableHeaderView : UIView

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *scalableImageView;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, assign) CGFloat defaultHeight;
@property (nonatomic, strong) UIColor *maskColor;

@end

@implementation _YPScalableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        
        _scalableImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _scalableImageView.contentMode = UIViewContentModeScaleAspectFill;
        _scalableImageView.clipsToBounds = YES;
        [self addSubview:_scalableImageView];
    }
    
    return self;
}

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:kContentOffset];
}

- (void)setScrollView:(UIScrollView *)scrollView {
    [_scrollView removeObserver:scrollView forKeyPath:kContentOffset];
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:kContentOffset options:NSKeyValueObservingOptionNew context:NULL];
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
        [self insertSubview:self.maskView aboveSubview:self.scalableImageView];
    }
    self.maskView.backgroundColor = maskColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat insetTop = self.scrollView.contentInset.top;
    CGFloat offsetY = self.scrollView.contentOffset.y + insetTop;
    if (offsetY < 0) {
        CGFloat height = self.defaultHeight - offsetY;
        self.frame = CGRectMake(0, offsetY - insetTop, self.frame.size.width, height);
        self.scalableImageView.frame = CGRectMake(offsetY, 0, self.frame.size.width - offsetY * 2, height);
    } else {
        self.frame = CGRectMake(0, -insetTop, self.frame.size.width, self.defaultHeight);
        self.scalableImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.defaultHeight);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self setNeedsLayout];
}

@end


@interface UIScrollView ()

@property (nonatomic, strong) _YPScalableHeaderView *headerView;

@end

@implementation UIScrollView (YPKit)

- (void)setScalableHeaderWithImage:(UIImage *)image
                     defaultHeight:(CGFloat)height
                         maskColor:(UIColor *)maskColor {
    if (!self.headerView) {
        self.headerView = [[_YPScalableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, height)];
        self.headerView.backgroundColor = [UIColor clearColor];
        self.headerView.autoresizingMask =
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
        self.headerView.scrollView = self;
        
        if ([self isKindOfClass:[UITableView class]]) {
            [(UITableView *)self setTableHeaderView:self.headerView];
        } else {
            [self addSubview:self.headerView];
            [self sendSubviewToBack:self.headerView];
            self.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
            if ([self isMemberOfClass:[UIScrollView class]] &&
                CGPointEqualToPoint(self.contentOffset, CGPointMake(0, 0))) {
                self.contentOffset = CGPointMake(0, -height);
            }
        }
    }
    self.headerView.scalableImageView.image = image;
    self.headerView.defaultHeight = height;
    self.headerView.maskColor = maskColor;
}

- (UIImageView *)scalableHeaderImageView {
    return self.headerView.scalableImageView;
}

- (void)setHeaderView:(_YPScalableHeaderView *)headerView {
    objc_setAssociatedObject(self, @selector(headerView), headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (_YPScalableHeaderView *)headerView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setScalableHeaderCustomView:(UIView *)customView {
    self.headerView.customView = customView;
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
