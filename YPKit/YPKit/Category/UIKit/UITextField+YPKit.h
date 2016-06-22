//
//  UITextField+YPKit.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-6.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (YPKit)
/**
 *  设置文字左边留出的空白宽度
 */
- (void)setContentPaddingLeft:(CGFloat)width;

/**
 *  设置文字右边留出的空白宽度
 */
- (void)setContentPaddingRight:(CGFloat)width;

/**
 *  设置attributeText
 *
 *  @param text  没有格式的text
 *  @param block 设置格式的block
 */
- (void)setText:(NSString *)text attributeString:(void(^)(NSMutableAttributedString *attrString))block;

/**
 *  设置placeholder文字和颜色
 */
- (void)setPlaceholder:(NSString *)placeholder withColor:(UIColor *)color;

/**
 *  隐藏iPad下，键盘上方的工具栏
 */
- (void)hideInputAssistantItem;

@end
