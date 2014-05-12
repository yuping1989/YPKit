//
//  NSArray+YPGeneral.m
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-17.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import "NSArray+YPGeneral.h"

@implementation NSArray (YPGeneral)
- (NSArray *)sortedArrayUsingKey:(NSString *)key ascending:(BOOL)ascending
{
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
    return [self sortedArrayUsingDescriptors:@[descriptor]];
}
@end
