//
//  UIViewController+YPGeneral.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "UIViewController+YPGeneral.h"
#define kProgressHUD @"kProgressHUD"
@implementation UIViewController (YPGeneral) 
+ (instancetype)instance;
{
    return [[self alloc] initWithNibName:[[self class] description] bundle:nil];
}

- (MBProgressHUD *)progressHUD {
    return objc_getAssociatedObject(self, kProgressHUD);
}

- (void)setProgressHUD:(UIImage *)progressHUD {
    objc_setAssociatedObject(self, kProgressHUD, progressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showProgressWithText:(NSString *)text
{
    [self showProgressOnView:self.view text:text userInteractionEnabled:YES];
}

- (void)showProgressOnWindowWithText:(NSString *)text
{
    [self showProgressOnView:[NativeUtil appDelegate].window text:text userInteractionEnabled:YES];
}

- (void)showProgressOnView:(UIView *)view text:(NSString *)text userInteractionEnabled:(BOOL)enabled
{
    if (self.progressHUD == nil) {
        self.progressHUD = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:self.progressHUD];
        self.progressHUD.delegate = self;
        [self.progressHUD show:YES];
    }
    self.progressHUD.labelText = text;
    NSLog(@"show");
    self.progressHUD.userInteractionEnabled = enabled;
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (self.progressHUD == nil) {
        return;
    }
    [self.progressHUD removeFromSuperview];
    self.progressHUD = nil;
    NSLog(@"hide");
}

- (void)hideProgress
{
    if (self.progressHUD == nil) {
        return;
    }
    [self.progressHUD hide:YES];
}

- (void)initRightBarButtonItemWithTitle:(NSString *)title
{
    [self initRightBarButtonItemWithTitle:title target:self];
}
- (void)initRightBarButtonItemWithTitle:(NSString *)title target:(id)target
{
#ifdef NAV_ITEM_TITLE_COLOR
    if (IOS7_AND_LATER) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:@selector(rightBarButtonClicked:)];
        self.navigationItem.rightBarButtonItem = item;
    }  else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:NAV_ITEM_TITLE_COLOR forState:UIControlStateNormal];
        [button setTitleColor:[NAV_ITEM_TITLE_COLOR colorWithAlphaComponent:0.3f]
                     forState:UIControlStateHighlighted];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTarget:target action:@selector(rightBarButtonClicked:)];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        button.frame = CGRectMake(0, 0, MAX(50, [title widthWithFont:button.titleLabel.font] + 5), 44);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = item;
    }
#else
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:@selector(rightBarButtonClicked:)];
    self.navigationItem.rightBarButtonItem = item;
#endif
}

- (void)initRightBarButtonItemWithImage:(UIImage *)image target:(id)target
{
    if (IOS7_AND_LATER) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleBordered target:target action:@selector(rightBarButtonClicked:)];
        self.navigationItem.rightBarButtonItem = item;
    } else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTarget:target action:@selector(rightBarButtonClicked:)];
        [button setImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, MAX(50, image.size.width), 44);
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = item;
    }
    
}

- (void)initLeftBarButtonItemWithTitle:(NSString *)title
{
    [self initLeftBarButtonItemWithTitle:title target:self];
}
- (void)initLeftBarButtonItemWithTitle:(NSString *)title target:(id)target
{
#ifdef NAV_ITEM_TITLE_COLOR
    if (IOS7_AND_LATER) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:@selector(leftBarButtonClicked:)];
        self.navigationItem.leftBarButtonItem = item;
    } else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:NAV_ITEM_TITLE_COLOR forState:UIControlStateNormal];
        [button setTitleColor:[NAV_ITEM_TITLE_COLOR colorWithAlphaComponent:0.3f]
                     forState:UIControlStateHighlighted];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTarget:target action:@selector(leftBarButtonClicked:)];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        button.frame = CGRectMake(0, 0, MAX(50, [title widthWithFont:button.titleLabel.font] + 5), 44);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = item;
    }
#else
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:@selector(leftBarButtonClicked:)];
    self.navigationItem.leftBarButtonItem = item;
#endif
}

- (void)initLeftBarButtonItemWithImage:(UIImage *)image target:(id)target
{
    if (IOS7_AND_LATER) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleBordered target:target action:@selector(leftBarButtonClicked:)];
        self.navigationItem.leftBarButtonItem = item;
    } else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTarget:target action:@selector(leftBarButtonClicked:)];
        [button setImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, MAX(50, image.size.width + 10), 44);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = item;
    }
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    if (self.view.window == nil) {
        return;
    }
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
    if (self.view.window == nil) {
        return;
    }
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

- (void)hideKeyboardWhenTapBackground
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewTapped:(UITapGestureRecognizer *)recognizer
{
    [NativeUtil hideKeyboard];
}

- (BOOL)isViewInBackground
{
    return [self isViewLoaded] && self.view.window == nil;
}

- (UIViewController *)topPresentedViewController
{
    if (self.presentedViewController) {
        return [self.presentedViewController topPresentedViewController];
    } else {
        return self;
    }
}
@end
