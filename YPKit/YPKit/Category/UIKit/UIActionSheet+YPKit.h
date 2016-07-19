//
//  UIActionSheet+YPKit.h
//  NBD2
//
//  Created by 喻平 on 16/6/22.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIActionSheet (YPKit)

- (void)showInView:(UIView *)view withCompletionBlock:(void (^)(NSInteger buttonIndex))completionBlock;

- (void)showFromToolbar:(UIToolbar *)view
    withCompletionBlock:(void (^)(NSInteger buttonIndex))completionBlock;

- (void)showFromTabBar:(UITabBar *)view
   withCompletionBlock:(void (^)(NSInteger buttonIndex))completionBlock;

- (void)showFromRect:(CGRect)rect
              inView:(UIView *)view
            animated:(BOOL)animated
 withCompletionBlock:(void (^)(NSInteger buttonIndex))completionBlock;

- (void)showFromBarButtonItem:(UIBarButtonItem *)item
                     animated:(BOOL)animated
          withCompletionBlock:(void (^)(NSInteger buttonIndex))completionBlock;

@end

NS_ASSUME_NONNULL_END
