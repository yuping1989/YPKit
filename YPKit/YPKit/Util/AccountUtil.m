//
//  AccountUtil.m
//  NBD2
//
//  Created by 喻平 on 15/12/11.
//  Copyright © 2015年 NBD2. All rights reserved.
//

#import "AccountUtil.h"

NSString * const UDAccountInfo = @"kUDAccountInfo";

@implementation AccountUtil

+ (void)saveAccount:(NSDictionary *)accountDict {
    [[NSUserDefaults standardUserDefaults] setObject:accountDict forKey:UDAccountInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDictionary *)account {
    return [[NSUserDefaults standardUserDefaults] objectForKey:UDAccountInfo];
}

+ (id)objectForKey:(NSString *)key {
    return [AccountUtil account][key];
}

+ (void)setObject:(id)object forKey:(NSString *)key {
    NSMutableDictionary *account = [NSMutableDictionary dictionaryWithDictionary:[AccountUtil account]];
    [account setObject:object forKey:key];
    [AccountUtil saveAccount:account];
}

@end
