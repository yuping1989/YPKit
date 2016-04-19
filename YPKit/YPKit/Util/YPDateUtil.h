//
//  YPDateUtil.h
//  NBD
//
//  Created by Tai Jason on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  日期格式
 */
extern NSString *const yyyyMMddHHmmss;
extern NSString *const yyyyMMddHHmm;
extern NSString *const yyyyMMdd;
extern NSString *const yyMMddHHmm;
extern NSString *const MMddHHmm;
extern NSString *const MMdd;
@interface YPDateUtil : NSObject
{
    NSDateFormatter *_dateFormatter;
    NSCalendar *_calendar;
}
+ (YPDateUtil *)shareInstance;
/**
 *  将日期格式化为字符串
 */
- (NSString *)stringWithDateTimeInterval:(NSTimeInterval)timeInterval;
- (NSString *)stringWithDateTimeInterval:(NSTimeInterval)timeInterval format:(NSString *)format;
- (NSString *)stringWithDateNumber:(NSNumber *)number;
- (NSString *)stringWithDateNumber:(NSNumber *)number format:(NSString *)format;
- (NSString *)stringWithDate:(NSDate *)date;
- (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;

/**
 *  将字符串转化为日期
 */
- (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;

/**
 *  获取日期是星期几, 1为星期天，2至7 为 星期一至星期六
 */
- (NSInteger)weekdayWithDate:(NSDate *)date;

/**
 *  获取日期是星期几, 返回星期一 ~ 星期天
 */
- (NSString *)weekdayStringWithDate:(NSDate *)date;

/**
 *  返回时间差
 */
- (NSString *)dateDiffStringWithFromDateString:(NSString *)dateString format:(NSString *)format;
- (NSString *)dateDiffStringWithFromTimeInterval:(NSTimeInterval)timeInterval;
- (NSString *)dateDiffStringWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

- (NSDateComponents *)getDateComponentsByFromDate:(NSDate *)fromDate ToDate:(NSDate *)toDate;

/**
 *  将传入的与当前时间进行对比，获取一个该日期的描述
 *  例如今天hh:mm，昨天hh:mm，前天hh:mm，x天前
 */
- (NSString *)formatDateNumber:(NSNumber *)number;
- (NSString *)formatDateTimeInterval:(NSTimeInterval)timeInterval;

+ (NSNumber *)numberWithCurrentDate;
@end
