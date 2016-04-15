//
//  NSSet+YPKit.h
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-8.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (YPKit)
- (NSArray *)sortedArrayWithKey:(NSString *)key ascending:(BOOL)ascending;
- (NSArray *)sortedArrayWithTerms:(NSDictionary *)sortTerm __deprecated;
- (NSArray *)sortedArrayWithFormat:(NSString *)formatString;
@end
