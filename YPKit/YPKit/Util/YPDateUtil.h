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
- (NSString *)stringWithDateTimeInterval:(int)timeInterval;
- (NSString *)stringWithDateTimeInterval:(int)timeInterval format:(NSString *)format;
- (NSString *)stringWithDateNumber:(NSNumber *)number;
- (NSString *)stringWithDateNumber:(NSNumber *)number format:(NSString *)format;

- (NSString *)stringWithDate:(NSDate *)date;
- (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;
+ (NSNumber *)numberWithCurrentDate;
- (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;
- (NSString *)weekStringWithDate:(NSDate *)date;

- (NSString *)dateDiffStringWithFromDateString:(NSString *)dateString format:(NSString *)format;
- (NSString *)dateDiffStringWithFromTimeInterval:(int)dateMills;
- (NSString *)dateDiffStringWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

- (NSDateComponents *)getDateComponentsByFromDate:(NSDate *)fromDate ToDate:(NSDate *)toDate;


@end
