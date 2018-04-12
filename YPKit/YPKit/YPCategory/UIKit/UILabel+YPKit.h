//
//  UILabel+YPKit.h
//  YPKit
//
//  Created by 喻平 on 14-6-12.
//  Copyright (c) 2014年 com.yp All rights reserved.
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

@end
