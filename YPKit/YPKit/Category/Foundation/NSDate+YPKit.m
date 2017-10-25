//
//  NSDate+YPKit.m
//  YPKit
//
//  Created by 喻平 on 2017/10/24.
//  Copyright © 2017年 YPKit. All rights reserved.
//

#import "NSDate+YPKit.h"

NSString *const YPDateFormat_yyyyMMddHHmmss = @"yyyy-MM-dd HH:mm:ss";
NSString *const YPDateFormat_yyyyMMddHHmm = @"yyyy-MM-dd HH:mm";
NSString *const YPDateFormat_yyyyMMdd = @"yyyy-MM-dd";
NSString *const YPDateFormat_yyMMddHHmm = @"yy-MM-dd HH:mm";
NSString *const YPDateFormat_MMddHHmm = @"MM-dd HH:mm";
NSString *const YPDateFormat_MMdd = @"MM-dd";

@implementation NSDate (YPKit)

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

+ (NSString *)stringWithTimeInterval:(NSTimeInterval)time format:(NSString *)format {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [date stringWithFormat:format];
}

+ (NSString *)stringWithNumber:(NSNumber *)number format:(NSString *)format {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:number.doubleValue];
    return [date stringWithFormat:format];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

- (NSString *)stringWithFormat:(NSString *)format
                      timeZone:(NSTimeZone *)timeZone
                        locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

+ (NSDate *)dateWithString:(NSString *)dateString
                    format:(NSString *)format
                  timeZone:(NSTimeZone *)timeZone
                    locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return [formatter dateFromString:dateString];
}

@end
