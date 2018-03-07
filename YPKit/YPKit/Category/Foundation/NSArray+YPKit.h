//
//  NSArray+YPKit.h
//  YPKit
//
//  Created by 喻平 on 14-4-17.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (YPKit)

/**
 *  对NSArray进行排序
 */
- (nullable NSArray *)sortedArrayWithKey:(NSString *)key ascending:(BOOL)ascending;

/**
 *  当有多个排序条件时，采用此方法
 *
 *  @param formatString 格式必须为@"key1:YES,key2:NO"
 *
 */
- (nullable NSArray *)sortedArrayWithFormat:(NSString *)formatString;

/**
 *  将NSArray转换为JSONString
 */
- (nullable NSString *)yp_jsonString;

/**
 *  从Plist文件中获取NSArray
 */
+ (nullable NSArray *)arrayWithPlistFile:(NSString *)name;

/**
 *  正向遍历
 */
- (void)each:(void (^)(ObjectType obj))block;
- (void)eachWithIdx:(void (^)(ObjectType obj, NSUInteger idx))block;

/**
 *  反向遍历
 */
- (void)eachReverse:(void (^)(ObjectType obj))block;
- (void)eachReverseWithIdx:(void (^)(ObjectType obj, NSUInteger idx))block;

@end

NS_ASSUME_NONNULL_END
