//
//  NSSet+YPKit.m
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-8.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import "NSSet+YPKit.h"

@implementation NSSet (YPKit)
- (NSArray *)sortedArrayWithKey:(NSString *)key ascending:(BOOL)ascending
{
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
    return [self sortedArrayUsingDescriptors:@[descriptor]];
}

- (NSArray *)sortedArrayWithTerms:(NSDictionary *)sortTerm
{
    NSMutableArray *descriptors = [NSMutableArray array];
    for (NSString *key in sortTerm.allKeys) {
        [descriptors addObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:[sortTerm[key] boolValue]]];
    }
    return [self sortedArrayUsingDescriptors:descriptors];
}

@end
