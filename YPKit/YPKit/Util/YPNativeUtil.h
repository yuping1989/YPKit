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



#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define APP_DELEGATE [YPNativeUtil appDelegate]
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

// 一个像素的宽度
#define ONE_PIXEL [YPNativeUtil onePixel]
// 返回设备名称，如iPhone 6S
#define DEVICE_NAME [YPNativeUtil deviceName]


#define AppVersionName [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
#define AppVersionCode [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define AppBundleDisplayName [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]


typedef void(^YPCompletionBlock)(void);
typedef void(^YPCompletionBlockWithData)(id data);

void YPOpenURLString(NSString *URLString);
void YPHideKeyboard();
void YPCallTelephone(NSString *phone);

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



+ (void)call:(NSString *)phone;

// 返回一个像素的宽度
+ (CGFloat)onePixel;





// 废弃的方法，用上方的函数替代
+ (void)hideKeyboard;
+ (void)openURLString:(NSString *)URLString;


// 废弃的方法，用上方的宏定义替代
+ (NSString *)appVersionName;
+ (NSInteger)appVersionCode;
+ (NSString *)deviceName; // 返回设备名称，如iPhone 6S

@end


