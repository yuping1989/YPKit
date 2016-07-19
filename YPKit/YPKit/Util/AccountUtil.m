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
    NSDictionary *account = [AccountUtil account];
    if (!account) {
        return;
    }
    NSMutableDictionary *newAccount = [NSMutableDictionary dictionaryWithDictionary:account];
    [newAccount setObject:object forKey:key];
    [AccountUtil saveAccount:newAccount];
}

@end
