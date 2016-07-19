//
//  NSTimer+YPKit.m
//  YPKit
//
//  Created by 喻平 on 16/7/6.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import "NSTimer+YPKit.h"

@implementation NSTimer (YPKit)

+ (void)yp_ExecBlock:(NSTimer *)timer {
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds
                                    repeats:(BOOL)repeats
                                      block:(void (^)(NSTimer *timer))block {
    return [NSTimer scheduledTimerWithTimeInterval:seconds
                                            target:self
                                          selector:@selector(yp_ExecBlock:)
                                          userInfo:[block copy]
                                           repeats:repeats];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds
                           repeats:(BOOL)repeats
                             block:(void (^)(NSTimer *timer))block {
    return [NSTimer timerWithTimeInterval:seconds
                                   target:self
                                 selector:@selector(yp_ExecBlock:)
                                 userInfo:[block copy]
                                  repeats:repeats];
}

@end
