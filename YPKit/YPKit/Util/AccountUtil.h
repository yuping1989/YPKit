//
//  AccountUtil.h
//  封装一些跟用户信息相关的操作，每个项目都会用到
//
//  Created by 喻平 on 15/12/11.
//  Copyright © 2015年 NBD2. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const UDAccountInfo;

@interface AccountUtil : NSObject

+ (void)saveAccount:(NSDictionary *)accountDict;
+ (NSDictionary *)account;
+ (id)objectForKey:(NSString *)key;
+ (void)setObject:(id)object forKey:(NSString *)key;

@end
