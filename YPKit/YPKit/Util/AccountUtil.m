//
//  AccountUtil.m
//  NBD2
//
//  Created by 喻平 on 15/12/11.
//  Copyright © 2015年 NBD2. All rights reserved.
//

#import "AccountUtil.h"
NSString *const kUDAccountInfo = @"kUDAccountInfo";

@implementation AccountUtil
+ (void)saveAccount:(NSDictionary *)accountDict {
    [[NSUserDefaults standardUserDefaults] setObject:accountDict forKey:kUDAccountInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDictionary *)account {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUDAccountInfo];
}

+ (id)objectForKey:(NSString *)key {
    return [AccountUtil account][key];
}
@end
