//
//  UIAlertView+YPKit.h
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-2.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockUI.h"
@interface UIAlertView (YPKit)
+ (UIAlertView *)showAlertWithTitle:(NSString *)title;

+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message;
+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message

         cancelButtonTitle:(NSString *)cancelButtonTitle;
+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                      okButtonTitle:(NSString *)okButtonTitle
                         completion:(void (^)(void))okButtonClicked;

+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                  otherButtonTitles:(NSArray *)otherButtonArray
                         completion:(void (^)(NSInteger buttonIndex))completion;
@end
