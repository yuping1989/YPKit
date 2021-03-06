//
//  UITextField+YPKit.h
//  YPKit
//
//  Created by 喻平 on 14-6-6.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (YPKit)

@property (nonatomic) CGFloat textPaddingLeft;
@property (nonatomic) CGFloat textPaddingRight;

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

NS_ASSUME_NONNULL_END
