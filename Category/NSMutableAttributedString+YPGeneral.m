//
//  NSMutableAttributedString+YPGeneral.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "NSMutableAttributedString+YPGeneral.h"

@implementation NSMutableAttributedString (YPGeneral)
- (void)addFont:(UIFont *)font range:(NSRange)rage
{
    [self addAttribute:NSFontAttributeName value:font range:rage];
}

- (void)addColor:(UIColor *)color range:(NSRange)rage
{
    [self addAttribute:NSForegroundColorAttributeName value:color range:rage];
}
@end
