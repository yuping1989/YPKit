//
//  NSAttributedString+YPKit.h
//  ChangQingQuan
//
//  Created by 喻平 on 15/3/31.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (YPKit)

/**
 *  返回NSMakeRange(0, self.length)
 */
- (NSRange)rangeOfAll;

/**
 *  根据文字的宽度来计算高度
 *  @param width 文字的宽度
 */
- (CGFloat)heightWithWidth:(CGFloat)width;

/**
 *  计算一行文字的宽度
 */
- (CGFloat)width;

@end
