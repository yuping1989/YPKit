//
//  UIAlertView+YPKit.h
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-2.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (YPKit)

// 显示title和一个“确定”按钮
+ (UIAlertView *)showAlertWithTitle:(NSString *)title;

// 显示title、message和一个“确定”按钮
+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message;

// 显示title、message，按钮名称自定义
+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle;

// 显示title和一个“确定”按钮，点击后有回调
+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                    okButtonClicked:(void (^)(void))okButtonClicked;

// 显示title和一个按钮，点击后有回调
+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                      okButtonTitle:(NSString *)okButtonTitle
                    okButtonClicked:(void (^)(void))okButtonClicked;

// 显示title、message和一个“确定”按钮，点击后有回调
+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                      okButtonTitle:(NSString *)okButtonTitle
                    okButtonClicked:(void (^)(void))okButtonClicked;

// 完全自定义
+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                  otherButtonTitles:(NSArray *)otherButtonTitles
                         completion:(void (^)(NSInteger buttonIndex))completion;

+ (UIAlertView *)showPlainTextInputAlertWithTitle:(NSString *)title
                                          message:(NSString *)message
                                   textFieldBlock:(void (^)(UITextField *textField))textFieldBlock
                                    okButtonTitle:(NSString *)okButtonTitle
                                       completion:(void (^)(NSString *text))okButtonClicked;

/**
 *  如果要使用此方法来接收按钮的点击事件，则不能额外设置UIAlertView的delegate，因为此方法会将delegate设置为self
 */
- (void)showWithCompletionBlock:(void (^)(NSInteger buttonIndex))completionBlock;

@end
