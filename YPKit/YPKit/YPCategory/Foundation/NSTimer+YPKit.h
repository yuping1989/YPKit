//
//  NSTimer+YPKit.h
//  YPKit
//
//  Created by 喻平 on 16/7/6.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (YPKit)

+ (NSTimer *)yp_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds
                                       repeats:(BOOL)repeats
                                         block:(void (^)(NSTimer *timer))block;

+ (NSTimer *)yp_timerWithTimeInterval:(NSTimeInterval)seconds
                              repeats:(BOOL)repeats
                                block:(void (^)(NSTimer *timer))block;
@end
