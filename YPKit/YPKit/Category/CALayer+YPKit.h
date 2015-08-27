//
//  CALayer+YPKit.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-7-21.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (YPKit)
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

- (CGFloat)height;
- (CGFloat)width;
- (CGFloat)x;
- (CGFloat)y;
@end
