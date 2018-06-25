//
//  UIAlertView+YPKit.m
//  YPKit
//
//  Created by 喻平 on 14-4-2.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import "UIAlertController+YPKit.h"
#import <objc/runtime.h>

@implementation UIAlertController (YPKit)

+ (instancetype)showAlertWithTitle:(NSString *)title {
    return [self showAlertWithTitle:title
                            message:nil];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message {
    return [self showAlertWithTitle:title
                            message:message
                  cancelButtonTitle:@"确定"];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle {
    if (!cancelButtonTitle) {
        return nil;
    }
    return [self showAlertWithTitle:title
                            message:message
                  cancelButtonTitle:cancelButtonTitle
                  otherButtonTitles:nil
                         completion:nil];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                   okButtonClicked:(void (^)(void))okButtonClicked {
    return [self showAlertWithTitle:title
                      okButtonTitle:@"确定"
                    okButtonClicked:okButtonClicked];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                     okButtonTitle:(NSString *)okButtonTitle
                   okButtonClicked:(void (^)(void))okButtonClicked {
    return [self showAlertWithTitle:title
                            message:nil
                      okButtonTitle:okButtonTitle
                    okButtonClicked:okButtonClicked];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                     okButtonTitle:(NSString *)okButtonTitle
                   okButtonClicked:(void (^)(void))okButtonClicked {
    return [self showAlertWithTitle:title
                            message:message
                  cancelButtonTitle:@"取消"
                  otherButtonTitles:@[okButtonTitle]
                         completion:^(NSInteger buttonIndex) {
                             if (buttonIndex == 1 && okButtonClicked) {
                                 okButtonClicked();
                             }
                         }];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                 otherButtonTitles:(NSArray *)otherButtonTitles
                        completion:(void (^)(NSInteger))completion {
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self showAlertWithTitle:title
                            message:message
                  cancelButtonTitle:cancelButtonTitle
                  otherButtonTitles:otherButtonTitles
                   inViewController:rootVC
                         completion:completion];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                 otherButtonTitles:(NSArray *)otherButtonTitles
                  inViewController:(UIViewController *)viewController
                        completion:(void (^)(NSInteger))completion {
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        return nil;
    }
    UIAlertController *alert = [self alertControllerWithTitle:title
                                                      message:message
                                                        style:UIAlertControllerStyleAlert
                                            cancelButtonTitle:cancelButtonTitle
                                            otherButtonTitles:otherButtonTitles
                                                   completion:completion];
    [viewController presentViewController:alert animated:YES completion:nil];
    return alert;
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                         textField:(void (^)(UITextField *textField))textField
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                 otherButtonTitles:(NSArray *)otherButtonTitles
                  inViewController:(UIViewController *)viewController
                        completion:(void (^)(NSInteger buttonIndex, UITextField *textField))completion {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:textField];
        __weak UIAlertController *weakAlert = alert;
        if (cancelButtonTitle) {
            [alert addActionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                __strong UIAlertController *strongAlert = weakAlert;
                if (completion) {
                    completion(0, [strongAlert.textFields firstObject]);
                }
            }];
        }
        if (otherButtonTitles.count > 0) {
            for (int i = 0; i < otherButtonTitles.count; i++) {
                UIAlertAction *action = [UIAlertAction actionWithTitle:otherButtonTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    __strong UIAlertController *strongAlert = weakAlert;
                    if (completion) {
                        completion(cancelButtonTitle ? i + 1 : i, [strongAlert.textFields firstObject]);
                    }
                }];
                [alert addAction:action];
            }
        }
        [viewController presentViewController:alert animated:YES completion:nil];
        return alert;
    } else {
        return nil;
    }
}

+ (instancetype)showActionSheetWithTitle:(NSString *)title
                                 message:(NSString *)message
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                       otherButtonTitles:(NSArray *)otherButtonTitles
                        inViewController:(UIViewController *)viewController
                              completion:(void (^)(NSInteger))completion {
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        return nil;
    }
    UIAlertController *alert = [self alertControllerWithTitle:title
                                                      message:message
                                                        style:UIAlertControllerStyleActionSheet
                                            cancelButtonTitle:cancelButtonTitle
                                            otherButtonTitles:otherButtonTitles
                                                   completion:completion];
    [viewController presentViewController:alert animated:YES completion:nil];
    return alert;
}

+ (instancetype)alertControllerWithTitle:(NSString *)title
                                 message:(NSString *)message
                                   style:(UIAlertControllerStyle)style
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                       otherButtonTitles:(NSArray *)otherButtonTitles
                              completion:(void (^)(NSInteger))completion {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    if (cancelButtonTitle) {
        [alert addActionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (completion) {
                completion(0);
            }
        }];
    }
    if (otherButtonTitles.count > 0) {
        for (int i = 0; i < otherButtonTitles.count; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:otherButtonTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (completion) {
                    completion(cancelButtonTitle ? i + 1 : i);
                }
            }];
            [alert addAction:action];
        }
    }
    return alert;
}

- (void)addActionWithTitle:(NSString *)title
                     style:(UIAlertActionStyle)style
                   handler:(void (^)(UIAlertAction *action))handler {
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:title
                                                          style:style
                                                        handler:handler];
    [self addAction:alertAction];
}

@end
