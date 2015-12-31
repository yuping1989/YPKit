//
//  AccountUtil.h
//  NBD2
//
//  Created by 喻平 on 15/12/11.
//  Copyright © 2015年 NBD2. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kUDAccountInfo;

@interface AccountUtil : NSObject
+ (void)saveAccount:(NSDictionary *)accountDict;
+ (NSDictionary *)account;
+ (id)objectForKey:(NSString *)key;
@end
