//
//  NSString+YPKit.h
//  YPKit
//
//  Created by 喻平 on 14-4-1.
//  Copyright (c) 2014年 com.yp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
 *  判断是否是QQ号
 */
- (BOOL)isQQ;

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

/**
 *  转化为NSNumber
 */
- (nullable NSNumber *)numberValue;

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
- (nullable id)yp_jsonObject;

/**
 *  返回NSMakeRange(0, self.length)
 */
- (NSRange)rangeOfAll;

/**
 *  搜索字符串中，某个字符串的位置
 *
 *  @return 匹配的个数
 */
- (NSInteger)enumerateRangesOfString:(NSString *)string
                          usingBlock:(void (^)(NSRange range, NSInteger index))block;

/**
 *  返回首字母，如果是中文，则返回其第一个字的拼音首字母
 */
- (NSString *)pinyinFirstLetter;

/**
 将参数列表格式的字符串转换成NSDictionary，格式：@"key1=value1&key2=value2"
 */
- (NSDictionary *)parameterStringToDictionary;

@end

NS_ASSUME_NONNULL_END

