//
//  UIAlertView+YPKit.m
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-4-2.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import "UIAlertView+YPKit.h"

@implementation UIAlertView (YPKit)
+ (UIAlertView *)showAlertWithTitle:(NSString *)title
{
    return [UIAlertView showAlertWithTitle:title
                                   message:nil];
}
+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
{
    return [UIAlertView showAlertWithTitle:title
                                   message:message
                         cancelButtonTitle:@"确定"];
}
+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
{
    return [UIAlertView showAlertWithTitle:title
                                   message:message
                         cancelButtonTitle:cancelButtonTitle
                         otherButtonTitles:nil
                                completion:nil];
}

+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
             okButtonTitle:(NSString *)okButtonTitle
                completion:(void (^)(void))okButtonClicked
{
    return [UIAlertView showAlertWithTitle:title
                                   message:message
                         cancelButtonTitle:@"取消"
                         otherButtonTitles:@[okButtonTitle]
                                completion:^(NSInteger buttonIndex) {
                                    if (buttonIndex == 1 && okButtonClicked) {
                                        okButtonClicked();
                                    }
                                }];
}

+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherButtonArray
                completion:(void (^)(NSInteger buttonIndex))completion

{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = title;
    alert.message = message;
    if (cancelButtonTitle) {
        [alert addButtonWithTitle:cancelButtonTitle];
    }
    if (otherButtonArray.count > 0) {
        for (int i = 0; i < otherButtonArray.count; i++) {
            [alert addButtonWithTitle:otherButtonArray[i]];
        }
    }
    [alert setCancelButtonIndex:0];
    [alert showWithCompletionHandler:completion];
    return alert;
}

@end
