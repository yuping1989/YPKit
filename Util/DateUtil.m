//
//  DateUtil.m
//  NBD
//
//  Created by Tai Jason on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+ (DateUtil *)shareInstance
{
    static DateUtil *dateUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateUtil = [[DateUtil alloc] init];
        [dateUtil initInstance];
    });
    return dateUtil;
}

- (void)initInstance
{
    _dateFormatter = [[NSDateFormatter alloc] init];
}
- (NSString *)stringWithDateNumber:(NSNumber *)number
{
    return [self stringWithDateNumber:number format:yyyyMMdd];
}

- (NSString *)stringWithDateNumber:(NSNumber *)number format:(NSString *)format
{
    return [self stringWithDate:[NSDate dateWithTimeIntervalSince1970:number.intValue] format:format];
}

- (NSString *)stringWithDateTimeInterval:(int)timeInterval
{
    return [self stringWithDateTimeInterval:timeInterval format:yyyyMMdd];
}

- (NSString *)stringWithDateTimeInterval:(int)timeInterval format:(NSString *)format
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

- (NSString *)formatDateWithCustom:(int)timeInterval
{
    [_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [_dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    int current = [[self dateWithString:[self stringWithDate:[NSDate date] format:@"yyyy-MM-dd"] format:@"yyyy-MM-dd"] timeIntervalSince1970] + 86400;
    NSLog(@"current-->%@", [self stringWithDateTimeInterval:timeInterval]);
    int diff = current - timeInterval;
    if (diff > 0 && diff <= 86400) {
        return [NSString stringWithFormat:@"今天 %@", [self stringWithDateTimeInterval:timeInterval format:@"H点"]];
    } else if (diff > 86400 && diff <= 172800) {
        return [NSString stringWithFormat:@"昨天 %@", [self stringWithDateTimeInterval:timeInterval format:@"H点"]];
    } else if (diff > 172800 && diff <= 258200) {
        return [NSString stringWithFormat:@"前天 %@", [self stringWithDateTimeInterval:timeInterval format:@"H点"]];
    } else {
        return [self stringWithDateTimeInterval:timeInterval format:@"M / d H点"];
    }
}

- (NSString *)getDateDiffWithFromTime:(int)dateMills
{
    NSDate *fromDate = [NSDate dateWithTimeIntervalSince1970:dateMills];
    NSDate *toDate = [NSDate date];
    return [self getDateDiffWithFromDate:fromDate toDate:toDate];
}

- (NSString *)getDateDiffWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSDateComponents *compInfo = [self getDateComponentsByFromDate:fromDate ToDate:toDate];
    int year = [compInfo year];
    int month = [compInfo month];
    int day = [compInfo day];
    int hour = [compInfo hour];
    int minute = [compInfo minute];
//    int second = [compInfo second];
    
    if (year > 0 || month > 0) {
        return [[DateUtil shareInstance] stringWithDate:fromDate format:MMdd];
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
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |
    NSDayCalendarUnit | NSHourCalendarUnit |
    NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *compInfo = [_calendar components:unitFlags
                                                fromDate:fromDate
                                                  toDate:toDate
                                                 options:0];
    return compInfo;
}

- (NSString *)getWeek:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    
    int week = [comps weekday];
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

+ (NSNumber *)numberWithCurrentDate
{
    return [NSNumber numberWithInt:[[NSDate date] timeIntervalSince1970]];
}
@end
