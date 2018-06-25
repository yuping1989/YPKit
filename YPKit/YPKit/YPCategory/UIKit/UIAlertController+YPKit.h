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
+ (instancetype)showAlertWithTitle:(NSString *)title;

// 显示title、message和一个“确定”按钮
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message;

// 显示title、message，按钮名称自定义
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle;

// 显示title和一个“确定”按钮，点击后有回调
+ (instancetype)showAlertWithTitle:(NSString *)title
                   okButtonClicked:(void (^)(void))okButtonClicked;

// 显示title和一个按钮，点击后有回调
+ (instancetype)showAlertWithTitle:(NSString *)title
                     okButtonTitle:(NSString *)okButtonTitle
                   okButtonClicked:(void (^)(void))okButtonClicked;

// 显示title、message和一个“确定”按钮，点击后有回调
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                     okButtonTitle:(NSString *)okButtonTitle
                   okButtonClicked:(void (^)(void))okButtonClicked;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                 otherButtonTitles:(NSArray *)otherButtonTitles
                        completion:(void (^)(NSInteger buttonIndex))completion;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                 otherButtonTitles:(NSArray *)otherButtonTitles
                  inViewController:(UIViewController *)viewController
                        completion:(void (^)(NSInteger buttonIndex))completion;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                         textField:(void (^)(UITextField *textField))textField
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                 otherButtonTitles:(NSArray *)otherButtonTitles
                  inViewController:(UIViewController *)viewController
                        completion:(void (^)(NSInteger buttonIndex, UITextField *textField))completion;

+ (instancetype)showActionSheetWithTitle:(NSString *)title
                                 message:(NSString *)message
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                       otherButtonTitles:(NSArray *)otherButtonTitles
                        inViewController:(UIViewController *)viewController
                              completion:(void (^)(NSInteger buttonIndex))completion;


/**
 创建一个UIAlertController

 @param title 标题
 @param message 消息
 @param style 类型
 @param cancelButtonTitle 取消按钮标题
 @param otherButtonTitles 其他按钮标题
 @param completion 回调block，
                   如果cancelButton存在，则cancelButton的index一定为0，otherButton的index从1开始递增，
                   如果不存在，则otherButton的index从0开始递增
 */
+ (instancetype)alertControllerWithTitle:(NSString *)title
                                 message:(NSString *)message
                                   style:(UIAlertControllerStyle)style
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                       otherButtonTitles:(NSArray *)otherButtonTitles
                              completion:(void (^)(NSInteger buttonIndex))completion;

- (void)addActionWithTitle:(NSString *)title
                     style:(UIAlertActionStyle)style
                   handler:(void (^)(UIAlertAction *action))handler;

@end

