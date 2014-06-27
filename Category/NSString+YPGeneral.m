//
//  NSString+YPGeneral.m
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-1.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import "NSString+YPGeneral.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (YPGeneral)
- (NSUInteger)charLength
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [self lengthOfBytesUsingEncoding:enc];
}


+ (BOOL)isEmpty:(NSString *)string
{
    if (string == nil) {
        return YES;
    }
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0 ? YES : NO;
}

+ (BOOL)isPositiveNumber:(NSString *)string
{
    if ([NSString isEmpty:string]) {
        return YES;
    }
    return [NSString isMatchRegex:REGEX_POSITIVE_NUMBER string:string];
}

+ (BOOL)isPositiveIntNumber:(NSString *)string
{
    if ([NSString isEmpty:string]) {
        return YES;
    }
    return [NSString isMatchRegex:REGEX_POSITIVE_INT string:string];
}

+ (BOOL)isMatchRegex:(NSString *)regex string:(NSString *)string
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:string]) {
        return YES;
    }
    return NO;
}

- (NSString *)stringByAppendSpaceToLength:(int)length
{
    int balance = length - self.charLength;
    NSMutableString *tmp = [NSMutableString stringWithString:self];
    if (balance > 0) {
        for (int i = 0; i < balance; i++) {
            [tmp appendString:@" "];
        }
    }
    return tmp;
}

- (NSString *)stringByInsertSpaceToLength:(int)length
{
    int balance = length - self.charLength;
    NSMutableString *tmp = [NSMutableString string];
    if (balance > 0) {
        for (int i = 0; i < balance; i++) {
            [tmp appendString:@" "];
        }
    }
    [tmp appendString:self];
    return tmp;
}

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (NSString *)stringWithArray:(NSArray *)array separator:(NSString *)separator
{
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < array.count; i++) {
        [string appendFormat:@"%@", array[i]];
        if (i != array.count - 1) {
            [string appendString:separator];
        }
    }
    return string;
}
@end
