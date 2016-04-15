//
//  YPNativeUtil.h
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-3-24.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#define IOS7_AND_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f ? YES : NO)

#define RGB(RED,GREEN,BLUE) [UIColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:1.0f]
#define RGBA(RED,GREEN,BLUE,ALPHA) [UIColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA]
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define APP_DELEGATE (AppDelegate *)[UIApplication sharedApplication].delegate
#define ONE_PIXEL [YPNativeUtil onePixel]

typedef void(^YPCompletionBlock)(void);
typedef void(^YPCompletionBlockWithData)(id data);


@interface YPNativeUtil : NSObject
+ (AppDelegate *)appDelegate;
+ (void)showToast:(NSString *)text;
+ (void)showToastInAppWindow:(NSString *)text;
+ (void)showToast:(NSString *)text
   hideAfterDelay:(NSTimeInterval)delay;
+ (void)showToast:(NSString *)text
           inView:(UIView *)view
   hideAfterDelay:(NSTimeInterval)delay;

+ (void)hideKeyboard;
+ (NSString *)appVersionName;
+ (NSInteger)appVersionCode;
+ (void)call:(NSString *)phone;
+ (CGFloat)onePixel;
+ (void)openURLString:(NSString *)URLString;
+ (NSString *)deviceName;
@end
