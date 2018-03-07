//
//  NSSet+YPKit.m
//  YPKit
//
//  Created by 喻平 on 14-4-8.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import "NSSet+YPKit.h"

@implementation NSSet (YPKit)
- (NSArray *)sortedArrayWithKey:(NSString *)key ascending:(BOOL)ascending {
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
    return [self sortedArrayUsingDescriptors:@[descriptor]];
}

- (NSArray *)sortedArrayWithFormat:(NSString *)formatString {
    NSMutableArray *descriptors = [NSMutableArray array];
    NSArray *descriptorStrings = [formatString componentsSeparatedByString:@","];
    for (NSString *descriptorString in descriptorStrings) {
        NSArray *keyValues = [descriptorString componentsSeparatedByString:@":"];
        NSString *key = [keyValues firstObject];
        NSString *value = [keyValues lastObject];
        [descriptors addObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:[@"YES" isEqualToString:value]]];
    }
    return [self sortedArrayUsingDescriptors:descriptors];
}

@end
