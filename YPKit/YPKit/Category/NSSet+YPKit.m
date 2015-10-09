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
@end
