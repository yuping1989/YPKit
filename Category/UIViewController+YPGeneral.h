//
//  UIViewController+YPGeneral.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YPGeneral)
+ (instancetype)instance;

- (void)initLeftBarButtonItemWithTitle:(NSString *)title;
- (void)initLeftBarButtonItemWithTitle:(NSString *)title target:(id)target;
- (void)leftBarButtonClicked:(id)sender;

- (void)initRightBarButtonItemWithTitle:(NSString *)title;
- (void)initRightBarButtonItemWithTitle:(NSString *)title target:(id)target;
- (void)rightBarButtonClicked:(id)sender;


// 键盘通知
- (void)registerKeyboardNotification;
- (void)removeKeyboardNotification;
- (void)keyboardWillShowWithRect:(CGRect)keyboardRect animationDuration:(float)duration;
- (void)keyboardWillHideWithRect:(CGRect)keyboardRect animationDuration:(float)duration;
@end
