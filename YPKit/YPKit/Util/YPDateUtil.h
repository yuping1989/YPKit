//
//  YPDateUtil.h
//  NBD
//
//  Created by Tai Jason on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

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
- (NSString *)stringWithDateTimeInterval:(NSTimeInterval)timeInterval;
- (NSString *)stringWithDateTimeInterval:(NSTimeInterval)timeInterval format:(NSString *)format;
- (NSString *)stringWithDateNumber:(NSNumber *)number;
- (NSString *)stringWithDateNumber:(NSNumber *)number format:(NSString *)format;

- (NSString *)stringWithDate:(NSDate *)date;
- (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;
+ (NSNumber *)numberWithCurrentDate;
- (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;
- (NSInteger)weekdayWithDate:(NSDate *)date;
- (NSString *)weekdayStringWithDate:(NSDate *)date;

- (NSString *)dateDiffStringWithFromDateString:(NSString *)dateString format:(NSString *)format;
- (NSString *)dateDiffStringWithFromTimeInterval:(NSTimeInterval)timeInterval;
- (NSString *)dateDiffStringWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

- (NSDateComponents *)getDateComponentsByFromDate:(NSDate *)fromDate ToDate:(NSDate *)toDate;

// 格式化时间
- (NSString *)formatDateNumber:(NSNumber *)number;
- (NSString *)formatDateTimeInterval:(NSTimeInterval)timeInterval;
@end
