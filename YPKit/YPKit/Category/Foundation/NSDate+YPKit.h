//
//  NSDate+YPKit.h
//  YPKit
//
//  Created by 喻平 on 2017/10/24.
//  Copyright © 2017年 YPKit. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  日期格式
 */
extern NSString *const YPDateFormat_yyyyMMddHHmmss;
extern NSString *const YPDateFormat_yyyyMMddHHmm;
extern NSString *const YPDateFormat_yyyyMMdd;
extern NSString *const YPDateFormat_yyMMddHHmm;
extern NSString *const YPDateFormat_MMddHHmm;
extern NSString *const YPDateFormat_MMdd;

@interface NSDate (YPKit)

@property (nonatomic, readonly) NSInteger weekday;

@end
