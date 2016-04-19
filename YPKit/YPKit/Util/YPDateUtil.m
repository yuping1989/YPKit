//
//  YPDateUtil.m
//  NBD
//
//  Created by Tai Jason on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "YPDateUtil.h"

NSString *const yyyyMMddHHmmss = @"yyyy-MM-dd HH:mm:ss";
NSString *const yyyyMMddHHmm = @"yyyy-MM-dd HH:mm";
NSString *const yyyyMMdd = @"yyyy-MM-dd";
NSString *const yyMMddHHmm = @"yy-MM-dd HH:mm";
NSString *const MMddHHmm = @"MM-dd HH:mm";
NSString *const MMdd = @"MM-dd";

@implementation YPDateUtil

+ (YPDateUtil *)shareInstance
{
    static YPDateUtil *dateUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateUtil = [[YPDateUtil alloc] init];
    });
    return dateUtil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return self;
}
- (NSString *)stringWithDateNumber:(NSNumber *)number
{
    return [self stringWithDateNumber:number format:yyyyMMdd];
}

- (NSString *)stringWithDateNumber:(NSNumber *)number format:(NSString *)format
{
    return [self stringWithDate:[NSDate dateWithTimeIntervalSince1970:number.doubleValue] format:format];
}

- (NSString *)stringWithDateTimeInterval:(NSTimeInterval)timeInterval
{
    return [self stringWithDateTimeInterval:timeInterval format:yyyyMMdd];
}

- (NSString *)stringWithDateTimeInterval:(NSTimeInterval)timeInterval format:(NSString *)format
{
    return [self stringWithDate:[NSDate dateWithTimeIntervalSince1970:timeInterval] format:format];
}

- (NSString *)stringWithDate:(NSDate *)date
{
    return [self stringWithDate:date format:yyyyMMdd];
}

- (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format
{
    [_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [_dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [_dateFormatter setDateFormat:format];
    return [_dateFormatter stringFromDate:date];
}


- (NSString *)dateDiffStringWithFromDateString:(NSString *)dateString format:(NSString *)format
{
    NSDate *date = [[YPDateUtil shareInstance] dateWithString:dateString format:format];
    return [self dateDiffStringWithFromDate:date toDate:[NSDate date]];
}

- (NSString *)dateDiffStringWithFromTimeInterval:(NSTimeInterval)timeInterval
{
    NSDate *fromDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDate *toDate = [NSDate date];
    return [self dateDiffStringWithFromDate:fromDate toDate:toDate];
}

- (NSString *)dateDiffStringWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSDateComponents *compInfo = [self getDateComponentsByFromDate:fromDate ToDate:toDate];
    NSInteger year = [compInfo year];
    NSInteger month = [compInfo month];
    NSInteger day = [compInfo day];
    NSInteger hour = [compInfo hour];
    NSInteger minute = [compInfo minute];
//    int second = [compInfo second];
    
    if (year > 0 || month > 0) {
        return [[YPDateUtil shareInstance] stringWithDate:fromDate format:MMdd];
    }
    if (day > 0) {
        if (day == 1) {
            return @"昨天";
        } else if (day == 2) {
            return @"前天";
        } else {
            return [NSString stringWithFormat:@"%d%@", day, @"天前"];
        }
    } else if (hour > 0) {
        return [NSString stringWithFormat:@"%d%@", hour, @"小时前"];
    } else if (minute> 0) {
        return [NSString stringWithFormat:@"%d%@", minute, @"分钟前"];
    } else {
        return @"刚刚";
    }
    return nil;
}

- (NSDateComponents *)getDateComponentsByFromDate:(NSDate *)fromDate ToDate:(NSDate *)toDate
{
    if (_calendar == nil) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    NSInteger unitFlags =
    NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    NSDateComponents *compInfo = [_calendar components:unitFlags
                                                fromDate:fromDate
                                                  toDate:toDate
                                                 options:NSCalendarWrapComponents];
    return compInfo;
}

- (NSInteger)weekdayWithDate:(NSDate *)date {
    if (_calendar == nil) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    NSInteger unitFlags =
    NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    NSDateComponents *comps = [_calendar components:unitFlags fromDate:date];
    
    return [comps weekday];
}

- (NSString *)weekdayStringWithDate:(NSDate *)date
{
    NSInteger week = [self weekdayWithDate:date];
    switch (week) {
        case 1:
            return @"星期天";
        case 2:
            return @"星期一";
        case 3:
            return @"星期二";
        case 4:
            return @"星期三";
        case 5:
            return @"星期四";
        case 6:
            return @"星期五";
        case 7:
            return @"星期六";
        default:
            break;
    }
    return nil;
}

- (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format
{
    [_dateFormatter setDateFormat:format];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date = [_dateFormatter dateFromString:dateString];
    return date;
}

- (NSString *)formatDateNumber:(NSNumber *)number {
    return [self formatDateTimeInterval:number.doubleValue];
}


- (NSString *)formatDateTimeInterval:(NSTimeInterval)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDate *currentDate = [NSDate date];
    NSString *currentDateString = [self stringWithDate:currentDate];
    int current = [currentDate timeIntervalSince1970];
    if (timeInterval > current) { //传入时间大于当前时间，返回
        return @"";
    }
    int todayZero = [[self dateWithString:currentDateString format:yyyyMMdd] timeIntervalSince1970];
    
    int dayDiff = (todayZero - timeInterval) / (24 * 3600);
    
    NSString *hour = [self stringWithDate:date format:@"HH:mm"];
    if (timeInterval >= todayZero) {
        return [NSString stringWithFormat:@"今天 %@", hour];
    } else {
        if (dayDiff == 0) {
            return [NSString stringWithFormat:@"昨天 %@", hour];
        } else if (dayDiff == 1) {
            return [NSString stringWithFormat:@"前天 %@", hour];
        } else {
            return [NSString stringWithFormat:@"%d天前", dayDiff + 1];
        }
        /*
         else {
            NSString *year = [self stringWithDate:date format:@"yyyy"];
            if ([year isEqualToString:[currentDateString substringToIndex:4]]) {
                return [self stringWithDate:date format:@"M月d日"];
            } else {
                return [self stringWithDate:date format:@"yyyy年M月d日"];
            }
        }*/
    }
}


+ (NSNumber *)numberWithCurrentDate
{
    return [NSNumber numberWithInt:[[NSDate date] timeIntervalSince1970]];
}
@end
