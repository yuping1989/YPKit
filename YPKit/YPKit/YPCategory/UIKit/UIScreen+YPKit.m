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
   if (@available(iOS 11.0, *)) {
       return [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;;
   } else {
       return [UIApplication sharedApplication].statusBarFrame.size.height;
   }
}

@end
