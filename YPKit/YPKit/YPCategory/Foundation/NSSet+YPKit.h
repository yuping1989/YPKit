//
//  NSSet+YPKit.h
//  YPKit
//
//  Created by 喻平 on 14-4-8.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSSet (YPKit)
/**
 *  对NSSet进行排序
 */
- (nullable NSArray *)sortedArrayWithKey:(NSString *)key ascending:(BOOL)ascending;

/**
 *  当有多个排序条件时，采用此方法
 *
 *  @param formatString 格式必须为@"key1:YES,key2:NO"
 *
 */
- (nullable NSArray *)sortedArrayWithFormat:(NSString *)formatString;

@end

NS_ASSUME_NONNULL_END
