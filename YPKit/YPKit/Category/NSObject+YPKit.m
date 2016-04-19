//
//  NSObject+YPKit.m
//  ChangQingQuan
//
//  Created by 喻平 on 15/4/3.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import "NSObject+YPKit.h"

@implementation NSObject (YPKit)
- (void)addNightModelSwitchedObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightModelSwitched:) name:NotiNightModelSwitched object:nil];
}

- (void)nightModelSwitched:(NSNotification *)notification {
    
}
@end
