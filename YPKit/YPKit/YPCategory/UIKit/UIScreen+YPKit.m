//
//  UIScreen+YPKit.m
//  YPKit
//
//  Created by 喻平 on 16/6/23.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import "UIScreen+YPKit.h"

@implementation UIScreen (YPKit)

+ (CGFloat)onePixel {
    UIScreen* mainScreen = [UIScreen mainScreen];
    if ([mainScreen respondsToSelector:@selector(nativeScale)]) {
        return 1.0f / mainScreen.nativeScale;
    } else {
        return 1.0f / mainScreen.scale;
    }
}

+ (CGFloat)statusBarHeight {
    CGFloat height = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (@available(iOS 11.0, *)) {
        if (IPHONE_X_SERIES) {
            height = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
        }
    }
    return height;
}

@end
