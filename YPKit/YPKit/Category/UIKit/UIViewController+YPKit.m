//
//  UIViewController+YPKit.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "UIViewController+YPKit.h"

@implementation UIViewController (YPKit)

+ (instancetype)instance; {
    return [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (MBProgressHUD *)progressHUD {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProgressHUD:(MBProgressHUD *)progressHUD {
    objc_setAssociatedObject(self, @selector(progressHUD), progressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showProgressWithText:(NSString *)text {
    [self showProgressOnView:self.view text:text userInteractionEnabled:YES];
}

- (void)showProgressOnWindowWithText:(NSString *)text {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [self showProgressOnView:window text:text userInteractionEnabled:YES];
}

- (void)showProgressOnView:(UIView *)view text:(NSString *)text userInteractionEnabled:(BOOL)enabled {
    if (!self.progressHUD) {
        self.progressHUD = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:self.progressHUD];
        self.progressHUD.delegate = self;
        [self.progressHUD show:YES];
    }
    self.progressHUD.labelText = text;
    self.progressHUD.userInteractionEnabled = enabled;
    
    NSLog(@"show progress");
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    if (!self.progressHUD) {
        return;
    }
    [self.progressHUD removeFromSuperview];
    self.progressHUD = nil;
    NSLog(@"hide progress");
}

- (void)hideProgress {
    if (!self.progressHUD) {
        return;
    }
    [self.progressHUD hide:YES];
}

- (void)initLeftBarButtonItemWithTitle:(NSString *)title {
    [self initLeftBarButtonItemWithTitle:title target:self];
}

- (void)initLeftBarButtonItemWithTitle:(NSString *)title target:(id)target {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:@selector(leftBarButtonClicked:)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)initLeftBarButtonItemWithImage:(UIImage *)image {
    [self initLeftBarButtonItemWithImage:image target:self];
}

- (void)initLeftBarButtonItemWithImage:(UIImage *)image target:(id)target {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleBordered target:target action:@selector(leftBarButtonClicked:)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)leftBarButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initRightBarButtonItemWithTitle:(NSString *)title {
    [self initRightBarButtonItemWithTitle:title target:self];
}

- (void)initRightBarButtonItemWithTitle:(NSString *)title target:(id)target {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:@selector(rightBarButtonClicked:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)initRightBarButtonItemWithImage:(UIImage *)image {
    [self initRightBarButtonItemWithImage:image target:self];
}

- (void)initRightBarButtonItemWithImage:(UIImage *)image target:(id)target {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleBordered target:target action:@selector(rightBarButtonClicked:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)initRightBarButtonItemWithTitle:(NSString *)title
                        backgroundImage:(UIImage *)bgImage
                                 target:(id)target {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTouchUpInsideTarget:target action:@selector(rightBarButtonClicked:)];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, MAX(50, [title widthWithFont:button.titleLabel.font] + 10), 28);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)rightBarButtonClicked:(id)sender {}

- (void)registerKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)addKeyboardObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    if ([self isViewInBackground]) {
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

- (void)keyboardWillHide:(NSNotification *)notification {
    if ([self isViewInBackground]) {
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

- (void)keyboardWillShowWithRect:(CGRect)keyboardRect animationDuration:(CGFloat)duration {}

- (void)keyboardWillHideWithRect:(CGRect)keyboardRect animationDuration:(CGFloat)duration {}

- (void)hideKeyboardWhenTapBackground {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewTapped:(UITapGestureRecognizer *)recognizer {
    [YPNativeUtil hideKeyboard];
}

- (BOOL)isViewInBackground {
    return [self isViewLoaded] && self.view.window == nil;
}

- (UIViewController *)topPresentedViewController {
    if (self.presentedViewController) {
        return [self.presentedViewController topPresentedViewController];
    } else {
        return self;
    }
}

- (void)presentNavControllerWithRootController:(UIViewController *)controller {
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:controller] animated:YES completion:nil];
}

- (void)setScrollViewContentHeight:(CGFloat)height {
    if (![self.view isKindOfClass:[UIScrollView class]]) {
        return;
    }
    [(UIScrollView *)self.view setContentSize:CGSizeMake(SCREEN_WIDTH, height)];
}
@end
