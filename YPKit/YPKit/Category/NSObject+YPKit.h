//
//  NSObject+YPKit.h
//  ChangQingQuan
//
//  Created by 喻平 on 15/4/3.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const NotiNightModelSwitched;
@interface NSObject (YPKit)

/**
 *  添加夜间模式切换的监听
 */
- (void)addNightModelSwitchedObserver;
- (void)nightModelSwitched:(NSNotification *)notification;
@end
