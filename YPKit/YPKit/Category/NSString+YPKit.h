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
- (NSUInteger)charLength;

+ (BOOL)isEmpty:(NSString *)string;
+ (BOOL)isPositiveNumber:(NSString *)string;
+ (BOOL)isPositiveIntNumber:(NSString *)string;

+ (BOOL)isMobile:(NSString *)string;

+ (BOOL)isMatchRegex:(NSString *)regex string:(NSString *)string;
- (BOOL)isMatchRegex:(NSString *)regex;


- (NSString *)stringByAppendSpaceToLength:(NSUInteger)length;
- (NSString *)stringByInsertSpaceToLength:(NSUInteger)length;

- (NSString *)MD5;

+ (NSString *)stringWithArray:(NSArray *)array separator:(NSString *)separator;
- (CGFloat)heightWithFont:(UIFont *)font width:(float)width;
- (CGFloat)widthWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width;
- (id)jsonObject;
- (NSString *)URLEncodedString;
- (NSInteger)rangesOfString:(NSString *)string
                 rangeBlock:(void (^)(NSRange range, NSInteger index))block;
@end
