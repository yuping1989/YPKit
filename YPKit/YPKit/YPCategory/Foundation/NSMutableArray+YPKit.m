//
//  NSMutableArray+YPKit.m
//  YPKit
//
//  Created by 喻平 on 2017/2/7.
//  Copyright © 2017年 yuping. All rights reserved.
//

#import "NSMutableArray+YPKit.h"

@implementation NSMutableArray (YPKit)

- (void)sortWithKey:(NSString *)key ascending:(BOOL)ascending {
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
    [self sortUsingDescriptors:@[descriptor]];
}

- (void)sortWithFormat:(NSString *)formatString {
    NSMutableArray *descriptors = [NSMutableArray array];
    NSArray *descriptorStrings = [formatString componentsSeparatedByString:@","];
    
    for (NSString *descriptorString in descriptorStrings) {
        NSArray *keyValues = [descriptorString componentsSeparatedByString:@":"];
        NSString *key = [keyValues firstObject];
        NSString *value = [keyValues lastObject];
        [descriptors addObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:[@"YES" isEqualToString:value]]];
    }
    [self sortUsingDescriptors:descriptors];
}

@end
