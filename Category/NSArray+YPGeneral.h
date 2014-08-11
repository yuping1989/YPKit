//
//  NSArray+YPGeneral.h
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-17.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YPGeneral)
- (NSArray *)sortedArrayUsingKey:(NSString *)key ascending:(BOOL)ascending;
- (NSString *)jsonString;
@end
