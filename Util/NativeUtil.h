//
//  NativeUtil.h
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-3-24.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#define IOS7_AND_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f ? YES : NO)

#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define rgb(RED,GREEN,BLUE) [UIColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:1.0f]

#define userDefaults [NSUserDefaults standardUserDefaults]

#define NSLogYP(tag, text) NSLog(@"%@-->%@", tag, text)

typedef void(^CompletionBlock)(void);
typedef void(^CompletionBlockWithData)(id data);

@interface NativeUtil : NSObject
+ (AppDelegate *)appDelegate;
+ (void)showToast:(NSString *)text;
+ (void)showToast:(NSString *)text inCenter:(BOOL)inCenter;
+ (void)showToast:(NSString *)text inCenter:(BOOL)inCenter hideAfterDelay:(NSTimeInterval)delay;

+ (void)hideKeyboard;
@end
