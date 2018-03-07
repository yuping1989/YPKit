//
//  NSDictionary+YPKit.h
//  YPKit
//
//  Created by 喻平 on 14-8-5.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (YPKit)

/**
 *  将NSDictionary转换为JSON字符串
 */
- (nullable NSString *)yp_jsonString;

/**
 *  从Plist文件中获取NSDictionary
 */
+ (nullable NSDictionary *)dictionaryWithPlistFile:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
