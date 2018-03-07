//
//  NSUserDefaults+YPKit.m
//  YPKit
//
//  Created by 喻平 on 16/10/12.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import "NSUserDefaults+YPKit.h"

@implementation NSUserDefaults (YPKit)

+ (void)saveInBlock:(void (^)(NSUserDefaults *ud))block {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (block) {
        block(userDefaults);
    }
    [userDefaults synchronize];
}

@end
