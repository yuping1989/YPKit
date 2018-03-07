//
//  UIAlertView+YPKit.h
//  YPKit
//
//  Created by 喻平 on 14-4-2.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (YPKit)

// 显示title和一个“确定”按钮
+ (UIAlertController *)showAlertWithTitle:(NSString *)title;

// 显示title、message和一个“确定”按钮
+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                                  message:(NSString *)message;

// 显示title、message，按钮名称自定义
+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                                  message:(NSString *)message
                        cancelButtonTitle:(NSString *)cancelButtonTitle;

// 显示title和一个“确定”按钮，点击后有回调
+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                          okButtonClicked:(void (^)(void))okButtonClicked;

// 显示title和一个按钮，点击后有回调
+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                            okButtonTitle:(NSString *)okButtonTitle
                          okButtonClicked:(void (^)(void))okButtonClicked;

// 显示title、message和一个“确定”按钮，点击后有回调
+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                                  message:(NSString *)message
                            okButtonTitle:(NSString *)okButtonTitle
                          okButtonClicked:(void (^)(void))okButtonClicked;


+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                                  message:(NSString *)message
                             buttonTitles:(NSArray *)buttonTitles
                               completion:(void (^)(NSInteger buttonIndex))completion;

+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                                  message:(NSString *)message
                                textField:(void (^)(UITextField *textField))textField
                             buttonTitles:(NSArray *)buttonTitles
                               completion:(void (^)(NSInteger buttonIndex, UITextField *textField))completion;

+ (UIAlertController *)alertControllerWithTitle:(NSString *)title
                                        message:(NSString *)message
                                   buttonTitles:(NSArray *)buttonTitles
                                     completion:(void (^)(NSInteger))completion;

- (void)addActionWithTitle:(NSString *)title
                     style:(UIAlertActionStyle)style
                   handler:(void (^)(UIAlertAction *action))handler;

@end
