//
//  NSMutableAttributedString+YPGeneral.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "NSMutableAttributedString+YPGeneral.h"

@implementation NSMutableAttributedString (YPGeneral)
- (void)addFont:(UIFont *)font range:(NSRange)range
{
    [self addAttribute:NSFontAttributeName value:font range:range];
}

- (void)addColor:(UIColor *)color range:(NSRange)range
{
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)addLineSpace:(float)space range:(NSRange)range
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:space];
    [self addAttribute:NSParagraphStyleAttributeName
                 value:style
                 range:range];
}
- (void)addDeleteLineWithRange:(NSRange)range
{
    [self addAttribute:NSStrikethroughStyleAttributeName
                 value:@(NSUnderlineStyleSingle)
                 range:range];
}
@end
