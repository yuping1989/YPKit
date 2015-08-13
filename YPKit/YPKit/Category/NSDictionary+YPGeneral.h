//
//  NSDictionary+YPGeneral.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-8-5.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YPGeneral)
- (NSString *)jsonString;
+ (NSDictionary *)dictionaryWithPlistFile:(NSString *)name;
@end
