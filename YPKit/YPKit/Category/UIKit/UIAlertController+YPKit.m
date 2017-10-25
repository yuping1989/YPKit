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
    return [UIAlertController showAlertWithTitle:title
                                         message:message
                               cancelButtonTitle:cancelButtonTitle
                               otherButtonTitles:nil
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
                               cancelButtonTitle:@"取消"
                               otherButtonTitles:@[okButtonTitle]
                                      completion:^(NSInteger buttonIndex) {
                                          if (buttonIndex == 1 && okButtonClicked) {
                                              okButtonClicked();
                                          }
                                      }];
}

+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                                  message:(NSString *)message
                        cancelButtonTitle:(NSString *)cancelButtonTitle
                        otherButtonTitles:(NSArray *)otherButtonTitles
                               completion:(void (^)(NSInteger buttonIndex))completion {
    return [self showAlertWithTitle:title
                            message:message
                     preferredStyle:UIAlertControllerStyleActionSheet
                  cancelButtonTitle:cancelButtonTitle
                  otherButtonTitles:otherButtonTitles
                         completion:completion];
}

+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                                  message:(NSString *)message
                           preferredStyle:(UIAlertControllerStyle)preferredStyle
                        cancelButtonTitle:(NSString *)cancelButtonTitle
                        otherButtonTitles:(NSArray *)otherButtonTitles
                               completion:(void (^)(NSInteger buttonIndex))completion {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
        
        if (cancelButtonTitle) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     if (completion) {
                                                                         completion(0);
                                                                     }
                                                                 }];
            [alertController addAction:cancelAction];
        }
        
        if (otherButtonTitles.count > 0) {
            for (int i = 0; i < otherButtonTitles.count; i++) {
                UIAlertAction *action = [UIAlertAction actionWithTitle:otherButtonTitles[i]
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   if (completion) {
                                                                       NSNumber *index = objc_getAssociatedObject(action, &alert_action_key);
                                                                       completion([index integerValue]);
                                                                   }
                                                               }];
                objc_setAssociatedObject(action, &alert_action_key, @(i + 1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [alertController addAction:action];
            }
        }
        UIViewController *rootController = [UIApplication sharedApplication].delegate.window.rootViewController;
        [rootController presentViewController:alertController animated:YES completion:nil];
        return alertController;
    } else {
        return nil;
    }
}

@end

