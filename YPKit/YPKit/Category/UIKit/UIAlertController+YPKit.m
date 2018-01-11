//
//  UIAlertView+YPKit.m
//  YPKit
//
//  Created by 喻平 on 14-4-2.
//  Copyright (c) 2014年 com.yp. All rights reserved.
//

#import "UIAlertController+YPKit.h"
#import <objc/runtime.h>

static const int alert_action_key;

@implementation UIAlertController (YPKit)

+ (UIAlertController *)showAlertWithTitle:(NSString *)title {
    return [UIAlertController showAlertWithTitle:title
                                         message:nil];
}

+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                                  message:(NSString *)message {
    return [UIAlertController showAlertWithTitle:title
                                         message:message
                               cancelButtonTitle:@"确定"];
}

+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                                  message:(NSString *)message
                        cancelButtonTitle:(NSString *)cancelButtonTitle {
    if (!cancelButtonTitle) {
        return nil;
    }
    return [UIAlertController showAlertWithTitle:title
                                         message:message
                                    buttonTitles:@[cancelButtonTitle]
                                      completion:nil];
}

+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                          okButtonClicked:(void (^)(void))okButtonClicked {
    return [UIAlertController showAlertWithTitle:title
                                   okButtonTitle:@"确定"
                                 okButtonClicked:okButtonClicked];
}

+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                            okButtonTitle:(NSString *)okButtonTitle
                          okButtonClicked:(void (^)(void))okButtonClicked {
    return [UIAlertController showAlertWithTitle:title
                                         message:nil
                                   okButtonTitle:okButtonTitle
                                 okButtonClicked:okButtonClicked];
}

+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                                  message:(NSString *)message
                            okButtonTitle:(NSString *)okButtonTitle
                          okButtonClicked:(void (^)(void))okButtonClicked {
    return [UIAlertController showAlertWithTitle:title
                                         message:message
                                    buttonTitles:@[@"取消", okButtonTitle]
                                      completion:^(NSInteger buttonIndex) {
                                          if (buttonIndex == 1 && okButtonClicked) {
                                              okButtonClicked();
                                          }
                                      }];
}

+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                                  message:(NSString *)message
                             buttonTitles:(NSArray *)buttonTitles
                               completion:(void (^)(NSInteger))completion {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIAlertController *alert = [self alertControllerWithTitle:title message:message buttonTitles:buttonTitles completion:completion];
        
        UIViewController *rootController = [UIApplication sharedApplication].delegate.window.rootViewController;
        [rootController presentViewController:alert animated:YES completion:nil];
        return alert;
    } else {
        return nil;
    }
}

+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                                  message:(NSString *)message
                                textField:(void (^)(UITextField *textField))textField
                             buttonTitles:(NSArray *)buttonTitles
                               completion:(void (^)(NSInteger buttonIndex, UITextField *textField))completion {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:textField];
        
        if (buttonTitles.count > 0) {
            for (int i = 0; i < buttonTitles.count; i++) {
                @weakify(alert)
                UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    @strongify(alert)
                    if (completion) {
                        NSNumber *index = objc_getAssociatedObject(action, &alert_action_key);
                        completion([index integerValue], [alert.textFields firstObject]);
                    }
                }];
                objc_setAssociatedObject(action, &alert_action_key, @(i), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [alert addAction:action];
            }
        }
        UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
        [rootVC presentViewController:alert animated:YES completion:nil];
        return alert;
    } else {
        return nil;
    }
}

+ (UIAlertController *)alertControllerWithTitle:(NSString *)title
                                        message:(NSString *)message
                                   buttonTitles:(NSArray *)buttonTitles
                                     completion:(void (^)(NSInteger))completion {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (buttonTitles.count > 0) {
        for (int i = 0; i < buttonTitles.count; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (completion) {
                    NSNumber *index = objc_getAssociatedObject(action, &alert_action_key);
                    completion([index integerValue]);
                }
            }];
            objc_setAssociatedObject(action, &alert_action_key, @(i), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

