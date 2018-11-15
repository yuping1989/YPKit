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

+ (NSDateFormatter *)yp_fixedFormatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    return formatter;
}

+ (NSDateFormatter *)yp_dynamicFormatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    return formatter;
}

+ (NSCalendar *)yp_calendar {
    static NSCalendar *calendar;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    });
    return calendar;
}

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [NSDate yp_fixedFormatter];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

+ (NSDate *)dateWithString:(NSString *)dateString
                    format:(NSString *)format
                  timeZone:(NSTimeZone *)timeZone
                    locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [NSDate yp_dynamicFormatter];
    [formatter setDateFormat:format];
    if (timeZone) {
        [formatter setTimeZone:timeZone];
    }
    if (locale) {
        [formatter setLocale:locale];
    }
    return [formatter dateFromString:dateString];
}

+ (NSString *)stringWithTimeInterval:(NSTimeInterval)time format:(NSString *)format {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [date stringWithFormat:format];
}

+ (NSString *)stringWithNumber:(NSNumber *)number format:(NSString *)format {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:number.doubleValue];
    return [date stringWithFormat:format];
}

+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *formatter = [NSDate yp_fixedFormatter];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSString *)stringWithDate:(NSDate *)date
                      format:(NSString *)format
                    timeZone:(NSTimeZone *)timeZone
                      locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [NSDate yp_dynamicFormatter];
    [formatter setDateFormat:format];
    if (timeZone) {
        [formatter setTimeZone:timeZone];
    }
    if (locale) {
        [formatter setLocale:locale];
    }
    return [formatter stringFromDate:date];
}

+ (NSString *)convertDateString:(NSString *)fromString
                     fromFormat:(NSString *)fromFormat
                       toFormat:(NSString *)toFormat {
    return [[self dateWithString:fromString format:fromFormat] stringWithFormat:toFormat];
}


+ (NSDateComponents *)dateComponentsWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSInteger unitFlags =   NSCalendarUnitYear |
                            NSCalendarUnitMonth |
                            NSCalendarUnitWeekOfMonth |
                            NSCalendarUnitDay |
                            NSCalendarUnitHour |
                            NSCalendarUnitMinute |
                            NSCalendarUnitSecond;
    NSDateComponents *components = [[self yp_calendar] components:unitFlags
                                                         fromDate:fromDate
                                                           toDate:toDate
                                                          options:NSCalendarWrapComponents];
    return components;
}

+ (NSString *)formatDate:(NSDate *)date style:(YPDateStyle)style {
    NSDate *currentDate = [NSDate date];
    
    NSInteger timeInterval = [date timeIntervalSince1970];
    NSInteger current = [currentDate timeIntervalSince1970];
    if (timeInterval >= current && style == YPDateStyleDefault) { //传入时间大于等于当前时间，返回
        return nil;
    }
    NSString *currentDateString = [currentDate stringWithFormat:YPDateFormat_yyyyMMdd];
    NSInteger todayZero = [[self dateWithString:currentDateString format:YPDateFormat_yyyyMMdd] timeIntervalSince1970];
    
    NSInteger day = (todayZero - timeInterval) / (24 * 3600);
    
    switch (style) {
        case YPDateStyleDefault: {
            NSDateComponents *compInfo = [self dateComponentsWithFromDate:date toDate:currentDate];
            NSInteger year = [compInfo year];
            NSInteger month = [compInfo month];
            NSInteger weekOfMonth = [compInfo weekOfMonth];
            NSInteger hour = [compInfo hour];
            NSInteger minute = [compInfo minute];
            NSInteger second = [compInfo second];
            if (year > 0 || month > 0) {
                return [self stringWithDate:date format:YPDateFormat_yyyyMMddHHmm];
            }
            if (weekOfMonth > 0) {
                return [NSString stringWithFormat:@"%zd%@", weekOfMonth, @"周前"];
            }
            if (timeInterval < todayZero) {
                if (day == 0) {
                    return @"昨天";
                } else if (day == 1) {
                    return @"前天";
                } else {
                    return [NSString stringWithFormat:@"%zd%@", day + 1, @"天前"];
                }
            }
            if (hour > 0) {
                return [NSString stringWithFormat:@"%zd%@", hour, @"小时前"];
            } else if (minute > 0) {
                return [NSString stringWithFormat:@"%zd%@", minute, @"分钟前"];
            } else {
                return [NSString stringWithFormat:@"%zd%@", second, @"秒前"];
            }
            break;
        }
        case YPDateStyleValue1: {
            NSString *hour = [date stringWithFormat:@"HH:mm"];
            if (timeInterval >= todayZero) {
                return [NSString stringWithFormat:@"今天 %@", hour];
            } else {
                if (day == 0) {
                    return [NSString stringWithFormat:@"昨天 %@", hour];
                } else if (day == 1) {
                    return [NSString stringWithFormat:@"前天 %@", hour];
                } else {
                    return [NSString stringWithFormat:@"%zd天前", day + 1];
                }
            }
            break;
        }
    }
    return nil;
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDate yp_fixedFormatter];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

- (NSString *)stringWithFormat:(NSString *)format
                      timeZone:(NSTimeZone *)timeZone
                        locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [NSDate yp_dynamicFormatter];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

@end
