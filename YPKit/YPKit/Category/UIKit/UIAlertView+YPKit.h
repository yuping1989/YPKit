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
                      okButtonTitle:(NSString *)okButtonTitle
                         completion:(void (^)(void))okButtonClicked;

+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                      okButtonTitle:(NSString *)okButtonTitle
                         completion:(void (^)(void))okButtonClicked;

+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                  otherButtonTitles:(NSArray *)otherButtonArray
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
