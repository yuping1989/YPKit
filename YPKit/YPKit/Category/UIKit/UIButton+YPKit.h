//
//  UIButton+YPKit.h
//  YPKit
//
//  Created by yuping on 14-6-4.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YPKit)

/**
 *  将UIButton的图片和文字设置为竖直居中
 *
 *  @param verticalOffset 竖直方向的偏移量
 *  @param spacing   image与title的距离
 */
- (void)setContentHorizontalCenterWithVerticalOffset:(CGFloat)verticalOffset
                                             spacing:(CGFloat)spacing;
- (void)setContentHorizontalCenterWithVerticalOffset:(CGFloat)spacing;

@end
