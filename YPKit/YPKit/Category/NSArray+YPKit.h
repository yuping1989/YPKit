//
//  NSArray+YPKit.h
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-17.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YPKit)
/**
 *  对NSArray进行排序
 */
- (NSArray *)sortedArrayWithKey:(NSString *)key ascending:(BOOL)ascending;

/**
 *  当有多个排序条件时，采用此方法
 *
 *  @param sortTerm 字典的格式为 @{@"key":@(YES)}
 *
 */
- (NSArray *)sortedArrayWithTerms:(NSDictionary *)sortTerm __deprecated;

/**
 *  当有多个排序条件时，采用此方法
 *
 *  @param formatString 格式必须为@"key1:YES,key2:NO"
 *
 */
- (NSArray *)sortedArrayWithFormat:(NSString *)formatString;

/**
 *  将NSArray转换为JSONString
 */
- (NSString *)jsonString;

/**
 *  从Plist文件中获取NSArray
 */
+ (NSArray *)arrayWithPlistFile:(NSString *)name;

@end
