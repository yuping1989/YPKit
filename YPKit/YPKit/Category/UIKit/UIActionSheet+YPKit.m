//
//  UIActionSheet+YPKit.m
//  NBD2
//
//  Created by 喻平 on 16/6/22.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import "UIActionSheet+YPKit.h"
#import <objc/runtime.h>

static const int block_key;

@interface UIActionSheet () <UIActionSheetDelegate>

@end

@implementation UIActionSheet (YPKit)

- (void)showInView:(UIView *)view withCompletionBlock:(void (^)(NSInteger buttonIndex))completionBlock {
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionBlock];
    [sheet showInView:view];
}

- (void)showFromToolbar:(UIToolbar *)view
    withCompletionBlock:(void (^)(NSInteger buttonIndex))completionBlock {
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionBlock];
    [sheet showFromToolbar:view];
}

- (void)showFromTabBar:(UITabBar *)view
   withCompletionBlock:(void (^)(NSInteger buttonIndex))completionBlock {
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionBlock];
    [sheet showFromTabBar:view];
}

- (void)showFromRect:(CGRect)rect
              inView:(UIView *)view
            animated:(BOOL)animated
 withCompletionBlock:(void (^)(NSInteger buttonIndex))completionBlock {
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionBlock];
    [sheet showFromRect:rect inView:view animated:animated];
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item
                     animated:(BOOL)animated
          withCompletionBlock:(void (^)(NSInteger buttonIndex))completionBlock {
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionBlock];
    [sheet showFromBarButtonItem:item animated:animated];
}

- (void)config:(void(^)(NSInteger buttonIndex))completionBlock {
    if (!completionBlock) return;
    
    objc_setAssociatedObject(self, &block_key, completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.delegate = self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    void (^completionBlock)(NSInteger buttonIndex) = objc_getAssociatedObject(self, &block_key);
    if(!completionBlock) return;
    
    completionBlock(buttonIndex);
}

@end
