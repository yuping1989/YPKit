//
//  NSString+YPKit.h
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-1.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"

#define REGEX_POSITIVE_NUMBER @"^(0|([1-9]\\d*))(\\.\\d+)?$"
#define REGEX_POSITIVE_INT @"^\\d+$"
#define REGEX_MOBILE @"^1[3|4|5|7|8][0-9]\\d{8}$"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YPKit)

#pragma mark - Encode and decode

- (nullable NSString *)base64EncodedString;
+ (nullable NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString;
- (NSString *)stringByURLEncode;
- (NSString *)stringByURLDecode;

#pragma mark - Size
/**
 *  根据文字字体，计算单行文字的宽度
 */
- (CGFloat)widthWithFont:(UIFont *)font;
- (CGFloat)heightWithFont:(UIFont *)font width:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

#pragma mark - Regular Expression

/**
 *  判断是否是手机号
 */
- (BOOL)isMobile;

/**
 *  判断是否是手机号
 */
- (BOOL)isEmail;

/**
 *  判断是否是正数
 */
- (BOOL)isPositiveNumber;

/**
 *  判断是否是正整数
 */
- (BOOL)isPositiveIntNumber;

/**
 *  判断正则表达式
 */
- (BOOL)matchesRegex:(NSString *)regex;
- (BOOL)matchesRegex:(NSString *)regex options:(NSRegularExpressionOptions)options;
- (void)enumerateRegexMatches:(NSString *)regex
                      options:(NSRegularExpressionOptions)options
                   usingBlock:(void (^)(NSString *match, NSRange matchRange, BOOL *stop))block;
- (NSString *)stringByReplacingRegex:(NSString *)regex
                             options:(NSRegularExpressionOptions)options
                          withString:(NSString *)replacement;

#pragma mark - Others

/**
 *  返回字符串的字符长度
 */
- (NSUInteger)charLength;

/**
 *  去除前后的空格和换行
 */
- (NSString *)stringByTrim;

/**
 *   nil, @"", @"  ", @"\n" 返回 NO; 其他返回 YES.
 */
- (BOOL)isNotBlank;

- (nullable NSNumber *)numberValue;

- (NSRange)rangeOfAll;

/**
 *  返回UTF-8编码的NSdata对象.
 */
- (nullable NSData *)dataValue;

/**
 *  返回MD5字符串
 */
- (nullable NSString *)md5String;

/**
 *  将字符串转换为JSON对象
 */
- (nullable id)jsonObject;

/**
 *  返回首字母，如果是中文，则返回其第一个字的拼音首字母
 */
- (nullable NSString *)pinyinFirstLetter;

/**
 *  搜索字符串中，某个字符串的位置
 *
 *  @return 匹配的个数
 */
- (NSInteger)enumerateRangesOfString:(NSString *)string
                          usingBlock:(void (^)(NSRange range, NSInteger index))block;


#pragma mark - Methods should be deprecated

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
 *  该方法可用NSArray的componentsJoinedByString方法替代，故废弃
 *
 *  @param array     字符串数组
 *  @param separator 分隔符
 */
+ (NSString *)stringWithArray:(NSArray<NSString *> *)array separator:(NSString *)separator __deprecated;





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

NS_ASSUME_NONNULL_END

