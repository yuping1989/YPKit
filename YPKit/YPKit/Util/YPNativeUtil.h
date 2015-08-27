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

#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [UIScreen mainScreen].currentMode.size.height > 960 : NO)
#define IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [UIScreen mainScreen].currentMode.size.height == 1334 : NO)

#define rgb(RED,GREEN,BLUE) [UIColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:1.0f]
#define rgba(RED,GREEN,BLUE,ALPHA) [UIColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA]
#define userDefaults [NSUserDefaults standardUserDefaults]

#define NSLogYP(tag, text) NSLog(@"%@-->%@", tag, text)

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

typedef void(^YPCompletionBlock)(void);
typedef void(^YPCompletionBlockWithData)(id data);


@interface YPNativeUtil : NSObject
+ (AppDelegate *)appDelegate;
+ (void)showToast:(NSString *)text;
+ (void)showToast:(NSString *)text inCenter:(BOOL)inCenter;
+ (void)showToast:(NSString *)text inCenter:(BOOL)inCenter hideAfterDelay:(NSTimeInterval)delay;

+ (void)hideKeyboard;
+ (NSString *)appVersionName;
+ (NSInteger)appVersionCode;
+ (void)call:(NSString *)phone;
@end