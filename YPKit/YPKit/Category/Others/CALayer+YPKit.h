//
//  CALayer+YPKit.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-7-21.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (YPKit)

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

- (CGFloat)maxY;
- (CGFloat)maxX;

@end
