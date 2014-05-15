//
//  UIViewController+YPGeneral.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "UIViewController+YPGeneral.h"

@implementation UIViewController (YPGeneral)
+ (instancetype)instance;
{
    return [[self alloc] initWithNibName:[[self class] description] bundle:nil];
}

- (void)initRightBarButtonItemWithTitle:(NSString *)title
{
    [self initRightBarButtonItemWithTitle:title target:self];
}
- (void)initRightBarButtonItemWithTitle:(NSString *)title target:(id)target
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:@selector(rightBarButtonClicked:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)initLeftBarButtonItemWithTitle:(NSString *)title
{
    [self initLeftBarButtonItemWithTitle:title target:self];
}
- (void)initLeftBarButtonItemWithTitle:(NSString *)title target:(id)target
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:@selector(leftBarButtonClicked:)];
    self.navigationItem.leftBarButtonItem = item;
}
- (void)leftBarButtonClicked:(id)sender
{
    
}


- (void)rightBarButtonClicked:(id)sender
{
    
}


- (void)registerKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardNotification
{
    NSLog(@"removeKeyboardNotification");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    NSLog(@"show-->%@  duration-->%f", NSStringFromCGRect([aValue CGRectValue]), animationDuration);
    [self keyboardWillShowWithRect:keyboardRect animationDuration:animationDuration];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    NSLog(@"hide-->%@  duration-->%f", NSStringFromCGRect([aValue CGRectValue]), animationDuration);
    [self keyboardWillHideWithRect:keyboardRect animationDuration:animationDuration];
}

- (void)keyboardWillShowWithRect:(CGRect)keyboardRect animationDuration:(float)duration
{
    
}

- (void)keyboardWillHideWithRect:(CGRect)keyboardRect animationDuration:(float)duration
{
    
}
@end
