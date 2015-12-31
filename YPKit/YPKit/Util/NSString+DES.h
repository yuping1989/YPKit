//
//  NSString+DES.h
//  HuoQiuJiZhang-debt
//
//  Created by yuping on 15/12/13.
//  Copyright © 2015年 com.huoqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DES)
+ (NSString *) encode:(NSString *)str key:(NSString *)key;
+ (NSString *) decode:(NSString *)str key:(NSString *)key;
@end
