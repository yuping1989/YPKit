//
//  UIScrollView+YPKit.h
//  MGMobileMusic
//
//  Created by 喻平 on 2016/12/29.
//  Copyright © 2016年 migu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPScalableHeaderView : UIView

@property (nonatomic, strong, readonly) UIImageView *scalableImageView;

@end

@interface UIScrollView (YPKit)

@property (nonatomic, strong, readonly) YPScalableHeaderView *yp_headerView;

- (void)setScalableHeaderWithImage:(UIImage *)image
                     defaultHeight:(CGFloat)height
                         maskColor:(UIColor *)maskColor;
- (void)setScalableHeaderWithImage:(UIImage *)image
                     defaultHeight:(CGFloat)height
                   imageViewInsets:(UIEdgeInsets)insets
                         maskColor:(UIColor *)maskColor;

- (void)setScalableHeaderCustomView:(UIView *)customView;

- (void)removeScalableHeader;

/**
 *  生成所有内容视图的快照图像
 */
- (UIImage *)contentSnapshotImage;

@end
