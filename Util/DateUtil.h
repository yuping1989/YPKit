//
//  DateUtil.h
//  NBD
//
//  Created by Tai Jason on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define yyyyMMddHHmmss @"yyyy-MM-dd HH:mm:ss"
#define yyyyMMddHHmm @"yyyy-MM-dd HH:mm"
#define yyMMddHHmm @"yy-MM-dd HH:mm"
#define MMddHHmm @"MM-dd HH:mm"
#define MMdd @"MM-dd"
#define yyyyMMdd @"yyyy-MM-dd"
@interface DateUtil : NSObject
{
    NSDateFormatter *_dateFormatter;
    NSCalendar *_calendar;
}
+ (DateUtil *)shareInstance;
- (NSString *)stringWithDateTimeInterval:(int)timeInterval;
- (NSString *)stringWithDateTimeInterval:(int)timeInterval format:(NSString *)format;
- (NSString *)stringWithDateNumber:(NSNumber *)number;
- (NSString *)stringWithDateNumber:(NSNumber *)number format:(NSString *)format;

- (NSString *)stringWithDate:(NSDate *)date;
- (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;
+ (NSNumber *)numberWithCurrentDate;


- (NSString *)formatDateWithCustom:(int)timeInterval;
- (NSString *)dateDiffStringWithFromTime:(int)dateMills;
- (NSString *)getDateDiffWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
- (NSString *)weekStringWithDate:(NSDate *)date;
- (NSDateComponents *)getDateComponentsByFromDate:(NSDate *)fromDate ToDate:(NSDate *)toDate;
- (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;

@end
