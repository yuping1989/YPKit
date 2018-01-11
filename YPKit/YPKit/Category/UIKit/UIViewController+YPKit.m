//
//  UIViewController+YPKit.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "UIViewController+YPKit.h"
#import "UIControl+YPKit.h"
#import <objc/runtime.h>
#import "NSString+YPKit.h"
#import "UIApplication+YPKit.h"
#import "UIScreen+YPKit.h"

static const int alert_action_key;

static const int leftBarButtonBlockKey;
static const int rightBarButtonBlockKey;

typedef void (^YPBarButtonBlock)(UIBarButtonItem *item);

@implementation UIViewController (YPKit)

+ (instancetype)viewControllerFromNib {
    return [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

#pragma mark - BarButtonItem

- (void)setLeftBarButtonItemTitle:(NSString *)title block:(void (^)(UIBarButtonItem *))block {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(leftBarButtonClicked:)];
    self.navigationItem.leftBarButtonItem = item;
    objc_setAssociatedObject(self, &leftBarButtonBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setLeftBarButtonItemImage:(UIImage *)image block:(void (^)(UIBarButtonItem *))block {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(leftBarButtonClicked:)];
    self.navigationItem.leftBarButtonItem = item;
    objc_setAssociatedObject(self, &leftBarButtonBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)leftBarButtonClicked:(id)sender {
    YPBarButtonBlock block = objc_getAssociatedObject(self, &leftBarButtonBlockKey);
    if (block) {
        block(sender);
    }
}

- (void)setRightBarButtonItemTitle:(NSString *)title block:(void (^)(UIBarButtonItem *))block {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(rightBarButtonClicked:)];
    self.navigationItem.rightBarButtonItem = item;
    objc_setAssociatedObject(self, &rightBarButtonBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setRightBarButtonItemImage:(UIImage *)image block:(void (^)(UIBarButtonItem *))block {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(rightBarButtonClicked:)];
    self.navigationItem.rightBarButtonItem = item;
    objc_setAssociatedObject(self, &rightBarButtonBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)rightBarButtonClicked:(id)sender {
    YPBarButtonBlock block = objc_getAssociatedObject(self, &rightBarButtonBlockKey);
    if (block) {
        block(sender);
    }
}

#pragma mark - Keyboard Observer

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

#pragma mark - Others

- (void)hideKeyboardWhenTapBackground {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewTapped:(UITapGestureRecognizer *)recognizer {
    [UIApplication hideKeyboard];
}

- (BOOL)isViewInBackground {
    return [self isViewLoaded] && self.view.window == nil;
}

- (UIViewController *)yp_topPresentedViewController {
    if (self.presentedViewController) {
        return [self.presentedViewController yp_topPresentedViewController];
    } else {
        return self;
    }
}

- (UIViewController *)yp_topViewController {
    UIViewController *topController = [self yp_topPresentedViewController];
    if ([topController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)topController;
        return navigationController.topViewController;
    } else {
        return topController;
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
