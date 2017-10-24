//
//  UIAlertView+YPKit.m
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-2.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import "UIAlertController+YPKit.h"
#import <objc/runtime.h>

//static const int alert_block_key;
static const int alert_action_key;

@implementation UIAlertController (YPKit)

+ (id)showAlertWithTitle:(NSString *)title {
    return [UIAlertController showAlertWithTitle:title
                                   message:nil];
}

+ (id)showAlertWithTitle:(NSString *)title
                 message:(NSString *)message {
    return [UIAlertController showAlertWithTitle:title
                                   message:message
                         cancelButtonTitle:@"确定"];
}

+ (id)showAlertWithTitle:(NSString *)title
                 message:(NSString *)message
       cancelButtonTitle:(NSString *)cancelButtonTitle {
    return [UIAlertController showAlertWithTitle:title
                                   message:message
                         cancelButtonTitle:cancelButtonTitle
                         otherButtonTitles:nil
                                completion:nil];
}

+ (id)showAlertWithTitle:(NSString *)title
         okButtonClicked:(void (^)(void))okButtonClicked {
    return [UIAlertController showAlertWithTitle:title
                             okButtonTitle:@"确定"
                           okButtonClicked:okButtonClicked];
}

+ (id)showAlertWithTitle:(NSString *)title
           okButtonTitle:(NSString *)okButtonTitle
         okButtonClicked:(void (^)(void))okButtonClicked {
    return [UIAlertController showAlertWithTitle:title
                                   message:nil
                             okButtonTitle:okButtonTitle
                           okButtonClicked:okButtonClicked];
}

+ (id)showAlertWithTitle:(NSString *)title
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

+ (id)showAlertWithTitle:(NSString *)title
                 message:(NSString *)message
       cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtonTitles:(NSArray *)otherButtonTitles
              completion:(void (^)(NSInteger buttonIndex))completion {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
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
        /*
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.title = title;
        alert.message = message;
        if (cancelButtonTitle) {
            [alert addButtonWithTitle:cancelButtonTitle];
        }
        if (otherButtonTitles.count > 0) {
            for (int i = 0; i < otherButtonTitles.count; i++) {
                [alert addButtonWithTitle:otherButtonTitles[i]];
            }
        }
        [alert setCancelButtonIndex:0];
        [alert showWithCompletionBlock:completion];
        return alert;*/
        return nil;
    }
}
/*
+ (id)showPlainTextInputAlertWithTitle:(NSString *)title
                               message:(NSString *)message
                        textFieldBlock:(void (^)(UITextField *textField))textFieldBlock
                         okButtonTitle:(NSString *)okButtonTitle
                            completion:(void (^)(NSString *text))okButtonClicked {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:okButtonTitle, nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alert textFieldAtIndex:0];
    if (textFieldBlock) {
        textFieldBlock(textField);
    }
    
    [alert showWithCompletionBlock:^(NSInteger buttonIndex) {
        if (okButtonClicked) {
            okButtonClicked(textField.text);
        }
    }];
    return alert;
}

- (void)showWithCompletionBlock:(void (^)(NSInteger))completionBlock {
    if (completionBlock) {
        objc_setAssociatedObject(self, &alert_block_key, completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        self.delegate = self;
    }
    
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    void (^completionBlock)(NSInteger buttonIndex) = objc_getAssociatedObject(self, &alert_block_key);
    if(!completionBlock) return;
    
    completionBlock(buttonIndex);
}
 */

@end
