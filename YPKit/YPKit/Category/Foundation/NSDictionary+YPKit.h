//
//  NSDictionary+YPKit.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-8-5.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YPKit)
/**
 *  将NSDictionary转换为JSON字符串
 */
- (NSString *)jsonString;

/**
 *  从Plist文件中获取NSDictionary
 */
+ (NSDictionary *)dictionaryWithPlistFile:(NSString *)name;
@end
