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

@interface NSString (YPKit)
- (NSUInteger)charLength;

+ (BOOL)isEmpty:(NSString *)string;
+ (BOOL)isPositiveNumber:(NSString *)string;
+ (BOOL)isPositiveIntNumber:(NSString *)string;
+ (BOOL)isMatchRegex:(NSString *)regex string:(NSString *)string;
- (BOOL)isMatchRegex:(NSString *)regex;
- (NSString *)stringByAppendSpaceToLength:(NSUInteger)length;
- (NSString *)stringByInsertSpaceToLength:(NSUInteger)length;

- (NSString *)md5;

+ (NSString *)stringWithArray:(NSArray *)array separator:(NSString *)separator;
- (CGFloat)heightWithFont:(UIFont *)font width:(float)width;
- (CGFloat)widthWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width;
- (id)jsonObject;
- (NSString *)URLEncodedString;
- (NSInteger)rangesOfString:(NSString *)string
                 rangeBlock:(void (^)(NSRange range, NSInteger index))block;
@end
