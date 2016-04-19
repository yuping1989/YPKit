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
/**
 *  通过RGB颜色值返回UIColor
 */
#define RGB(RED,GREEN,BLUE) [UIColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:1.0f]
#define RGBA(RED,GREEN,BLUE,ALPHA) [UIColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA]

#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define APP_DELEGATE (AppDelegate *)[UIApplication sharedApplication].delegate

// 一个像素的宽度
#define ONE_PIXEL [YPNativeUtil onePixel]

typedef void(^YPCompletionBlock)(void);
typedef void(^YPCompletionBlockWithData)(id data);


@interface YPNativeUtil : NSObject
+ (AppDelegate *)appDelegate;

// 在最上层的UIWindow上显示一个简短的提示，不会被键盘遮挡
+ (void)showToast:(NSString *)text;
+ (void)showToast:(NSString *)text
   hideAfterDelay:(NSTimeInterval)delay;

// 在最底层UIWindow上显示一个简短的提示，有键盘存在时，可能会被遮挡
+ (void)showToastInAppWindow:(NSString *)text;

+ (void)showToast:(NSString *)text
           inView:(UIView *)view
   hideAfterDelay:(NSTimeInterval)delay;

+ (void)hideKeyboard;
+ (NSString *)appVersionName;
+ (NSInteger)appVersionCode;
+ (void)call:(NSString *)phone;

// 返回一个像素的宽度
+ (CGFloat)onePixel;
+ (void)openURLString:(NSString *)URLString;
+ (NSString *)deviceName;
@end
