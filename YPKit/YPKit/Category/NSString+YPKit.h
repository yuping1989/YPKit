//
//  NSString+YPKit.h
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-1.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define REGEX_POSITIVE_NUMBER @"^(0|([1-9]\\d*))(\\.\\d+)?$"
#define REGEX_POSITIVE_INT @"^\\d+$"
#define REGEX_MOBILE @"^1[3|4|5|7|8][0-9]\\d{8}$"

@interface NSString (YPKit)
/**
 *  返回字符串的字符长度
 */
- (NSUInteger)charLength;
/**
 *  去掉前后的空格后，判断是否为空
 */
+ (BOOL)isEmpty:(NSString *)string;
/**
 *  判断是否是正数
 */
+ (BOOL)isPositiveNumber:(NSString *)string;
/**
 *  判断是否是正整数
 */
+ (BOOL)isPositiveIntNumber:(NSString *)string;
/**
 *  判断是否是手机号
 */
+ (BOOL)isMobile:(NSString *)string;
/**
 *  匹配正则表达式
 */
+ (BOOL)isMatchRegex:(NSString *)regex string:(NSString *)string;
/**
 *  匹配正则表达式
 */
- (BOOL)isMatchRegex:(NSString *)regex;


- (NSString *)stringByAppendSpaceToLength:(NSUInteger)length;
- (NSString *)stringByInsertSpaceToLength:(NSUInteger)length;

- (NSString *)MD5;
/**
 *  根据字符串数组的元素和分隔符，返回字符串
 *
 *  @param array     字符串数组
 *  @param separator 分隔符
 */
+ (NSString *)stringWithArray:(NSArray<NSString *> *)array separator:(NSString *)separator;

/**
 *  根据文字的宽度和字体，计算文字的高度
 */
- (CGFloat)heightWithFont:(UIFont *)font width:(float)width;

/**
 *  根据文字字体，计算单行文字的宽度
 */
- (CGFloat)widthWithFont:(UIFont *)font;
/**
 *  根据文字的宽度和字体，计算文字的Size
 */
- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width;

/**
 *  将字符串转换为JSON对象
 */
- (id)jsonObject;

/**
 *  URL编码
 */
- (NSString *)URLEncodedString;

/**
 *  搜索字符串中，某个字符串的位置
 */
- (NSInteger)rangesOfString:(NSString *)string
                 rangeBlock:(void (^)(NSRange range, NSInteger index))block;
@end
