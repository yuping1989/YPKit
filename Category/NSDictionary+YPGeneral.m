//
//  NSDictionary+YPGeneral.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-8-5.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "NSDictionary+YPGeneral.h"

@implementation NSDictionary (YPGeneral)
- (NSString *)jsonString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end
