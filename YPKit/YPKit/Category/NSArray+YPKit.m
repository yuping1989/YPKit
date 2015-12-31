//
//  NSArray+YPKit.m
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-17.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import "NSArray+YPKit.h"

@implementation NSArray (YPKit)
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

- (NSString *)jsonString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSArray *)arrayWithPlistFile:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:path];
}

@end
