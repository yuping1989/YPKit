//
//  UILabel+YPKit.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YPKit)
/**
 *  设置attributeText
 *
 *  @param text  没有格式的text
 *  @param block 设置格式的block
 */
- (void)setText:(NSString *)text attributeString:(void(^)(NSMutableAttributedString *attrString))block;

#pragma mark - Methods should be deprecated

/**
 *  重置UILabel的高度，来显示所有的文字
 *
 *  @param isAttributedText 是否为AttributedText
 */
- (void)resizeToFitHeight:(BOOL)isAttributedText;

/**
 *  重置UILabel的宽度，来显示所有的文字
 *
 *  @param isAttributedText 是否为AttributedText
 */
- (void)resizeToFitWidth:(BOOL)isAttributedText;

@end
