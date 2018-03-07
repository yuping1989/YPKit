//
//  NSUserDefaults+YPKit.h
//  YPKit
//
//  Created by 喻平 on 16/10/12.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (YPKit)

+ (void)saveInBlock:(void (^)(NSUserDefaults *ud))block;

@end
