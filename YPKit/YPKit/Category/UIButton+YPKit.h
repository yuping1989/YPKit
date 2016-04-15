//
//  UIButton+YPKit.h
//  PiFuKeYiSheng
//
//  Created by yuping on 14-6-4.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YPKit)
@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)setContentHorizontalCenterWithSpacing:(CGFloat)spacing;

/**
 *  将UIButton的图片和文字设置为竖直居中
 *
 *  @param marginTop image与顶部的距离
 *  @param spacing   image与title的距离
 */
- (void)setContentHorizontalCenterWithMarginTop:(CGFloat)marginTop
                                        spacing:(CGFloat)spacing;
/**
 *  设置点击事件的target
 */
- (void)addTouchUpInsideTarget:(id)target action:(SEL)action;
@end
