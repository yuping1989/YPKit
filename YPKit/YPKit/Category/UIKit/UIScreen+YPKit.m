//
//  UIScreen+YPKit.m
//  NBD2
//
//  Created by 喻平 on 16/6/23.
//  Copyright © 2016年 NBD2. All rights reserved.
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

@end
