//
//  NSString+YPGeneral.h
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-1.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define REGEX_POSITIVE_NUMBER @"^(0|([1-9]\\d*))(\\.\\d+)?$"
#define REGEX_POSITIVE_INT @"^\\d+$"

@interface NSString (YPGeneral)
- (NSUInteger)charLength;

+ (BOOL)isEmpty:(NSString *)string;
+ (BOOL)isPositiveNumber:(NSString *)string;
+ (BOOL)isPositiveIntNumber:(NSString *)string;
+ (BOOL)isMatchRegex:(NSString *)regex string:(NSString *)string;
- (BOOL)isMatchRegex:(NSString *)regex;
- (NSString *)stringByAppendSpaceToLength:(int)length;
- (NSString *)stringByInsertSpaceToLength:(int)length;

- (NSString *)md5;

+ (NSString *)stringWithArray:(NSArray *)array separator:(NSString *)separator;
- (int)heightWithFont:(UIFont *)font width:(float)width;
- (int)widthWithFont:(UIFont *)font;
- (id)jsonObject;
- (NSString *)URLEncodedString;
- (NSInteger)rangesOfString:(NSString *)string
                 rangeBlock:(void (^)(NSRange range, NSInteger index))block;
@end
