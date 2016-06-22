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

- (NSString *)jsonString {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        if (error) {
            NSLog(@"jsonString error:%@", error);
        }
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSArray *)arrayWithPlistFile:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:path];
}

- (void)each:(void (^)(id obj))block {
    NSParameterAssert(block != nil);
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(obj);
    }];
}

- (void)eachWithIdx:(void (^)(id obj, NSUInteger idx))block {
    NSParameterAssert(block != nil);
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(obj, idx);
    }];
}

- (void)eachReverse:(void (^)(id obj))block {
    NSParameterAssert(block != nil);
    
    [self enumerateObjectsWithOptions:NSEnumerationReverse
                           usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                               block(obj);
                           }];
}

- (void)eachReverseWithIdx:(void (^)(id obj, NSUInteger idx))block {
    NSParameterAssert(block != nil);
    
    [self enumerateObjectsWithOptions:NSEnumerationReverse
                           usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                               block(obj, idx);
                           }];
}

@end
