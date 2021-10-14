//
//  UIDevice+YPKit.h
//  YPKit
//
//  Created by 喻平 on 16/6/22.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YP_SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]

#define YP_IOS17 (YP_SYSTEM_VERSION >= 17.0 ? YES : NO)
#define YP_IOS16 (YP_SYSTEM_VERSION >= 16.0 ? YES : NO)
#define YP_IOS15 (YP_SYSTEM_VERSION >= 15.0 ? YES : NO)
#define YP_IOS14 (YP_SYSTEM_VERSION >= 14.0 ? YES : NO)
#define YP_IOS13 (YP_SYSTEM_VERSION >= 13.0 ? YES : NO)
#define YP_IOS12 (YP_SYSTEM_VERSION >= 12.0 ? YES : NO)
#define YP_IOS11 (YP_SYSTEM_VERSION >= 11.0 ? YES : NO)
#define YP_IOS10 (YP_SYSTEM_VERSION >= 10.0 ? YES : NO)
#define YP_IOS9 (YP_SYSTEM_VERSION >= 9.0 ? YES : NO)
#define YP_IOS8 (YP_SYSTEM_VERSION >= 8.0 ? YES : NO)

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (YPKit)

// 判断设备是否为iPad/iPad mini.
@property (nonatomic, readonly) BOOL isPad;

// 判断设备是否为模拟器
@property (nonatomic, readonly) BOOL isSimulator;

// 判断设备是否能打电话
@property (nonatomic, readonly) BOOL canMakePhoneCalls NS_EXTENSION_UNAVAILABLE_IOS("");

// 设备型号，例如："iPhone6,1" "iPad4,6"
// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly) NSString *yp_machineModel;

// 设备型号名称，例如："iPhone 5s" "iPad mini 2"
// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly) NSString *yp_machineModelName;

#pragma mark - Disk Space

// 总的存储空间
@property (nonatomic, readonly) int64_t diskSpace;

// 空余存储空间
@property (nonatomic, readonly) int64_t diskSpaceFree;

// 已使用的存储空间
@property (nonatomic, readonly) int64_t diskSpaceUsed;

// 获取wifi下的ip地址 @"192.168.1.111"
@property (nullable, nonatomic, readonly) NSString *ipAddressWIFI;

// 获取ip地址 @"10.2.2.222"
@property (nullable, nonatomic, readonly) NSString *ipAddressCell;

@end

NS_ASSUME_NONNULL_END
