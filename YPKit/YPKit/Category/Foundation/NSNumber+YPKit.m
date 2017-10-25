//
//  NSNumber+YPKit.m
//  YPKit
//
//  Created by 喻平 on 14-4-1.
//  Copyright (c) 2014年 com.yp. All rights reserved.
//

#import "NSNumber+YPKit.h"

@implementation NSNumber (YPKit)
- (NSString *)toString {
    if ([@"0" isEqualToString:self.stringValue]) {
        return @"";
    } else {
        return self.stringValue;
    }
}

+ (NSNumber *)numberWithCurrentDate {
    return [NSNumber numberWithInt:[[NSDate date] timeIntervalSince1970]];
}
@end
