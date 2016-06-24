//
//  UIDevice+YPKit.h
//  NBD2
//
//  Created by 喻平 on 16/6/22.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IOS7_AND_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f ? YES : NO)

@interface UIDevice (YPKit)

+ (double)systemVersion;

/// 判断设备是否为iPad/iPad mini.
@property (nonatomic, readonly) BOOL isPad;

/// 判断设备是否为模拟器
@property (nonatomic, readonly) BOOL isSimulator;

/// 判断设备是否能打电话
@property (nonatomic, readonly) BOOL canMakePhoneCalls NS_EXTENSION_UNAVAILABLE_IOS("");

/// 设备型号，例如："iPhone6,1" "iPad4,6"
/// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly) NSString *machineModel;

/// 设备型号名称，例如："iPhone 5s" "iPad mini 2"
/// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly) NSString *machineModelName;

#pragma mark - Disk Space

/// 总的存储空间
@property (nonatomic, readonly) int64_t diskSpace;

/// 空余存储空间
@property (nonatomic, readonly) int64_t diskSpaceFree;

/// 已使用的存储空间
@property (nonatomic, readonly) int64_t diskSpaceUsed;
@end
