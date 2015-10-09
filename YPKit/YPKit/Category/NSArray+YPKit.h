//
//  NSArray+YPKit.h
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-17.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YPKit)
- (NSArray *)sortedArrayWithKey:(NSString *)key ascending:(BOOL)ascending;
- (NSString *)jsonString;
+ (NSArray *)arrayWithPlistFile:(NSString *)name;

@end
