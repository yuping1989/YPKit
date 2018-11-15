//
//  UIViewController+YPKit.m
//  YPKit
//
//  Created by 喻平 on 14-5-12.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import "UIViewController+YPKit.h"
#import <objc/runtime.h>

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

#pragma mark - Others

- (void)hideKeyboardWhenTapBackground {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewTapped:(UITapGestureRecognizer *)recognizer {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (BOOL)isViewInBackground {
    return [self isViewLoaded] && !self.view.window;
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

@end
