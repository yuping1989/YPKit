//
//  NSMutableArray+YPKit.h
//  YPKit
//
//  Created by 喻平 on 2017/2/7.
//  Copyright © 2017年 yuping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (YPKit)

/**
 *  对NSArray进行排序
 */
- (void)sortWithKey:(NSString *)key ascending:(BOOL)ascending;

/**
 *  当有多个排序条件时，采用此方法
 *
 *  @param formatString 格式必须为@"key1:YES,key2:NO"
 *
 */
- (void)sortWithFormat:(NSString *)formatString;

@end

NS_ASSUME_NONNULL_END
