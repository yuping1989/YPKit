//
//  NSMutableAttributedString+YPKit.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "NSMutableAttributedString+YPKit.h"

@implementation NSMutableAttributedString (YPKit)


- (void)addFont:(UIFont *)font {
    [self addFont:font range:NSMakeRange(0, self.length)];
}

- (void)addFont:(UIFont *)font range:(NSRange)range
{
    [self addAttribute:NSFontAttributeName value:font range:range];
}

- (void)addFont:(UIFont *)font string:(NSString *)string
{
    [self.string rangesOfString:string
                     rangeBlock:^(NSRange range, NSInteger index) {
                         [self addFont:font range:range];
                     }];
}

- (void)addColor:(UIColor *)color range:(NSRange)range
{
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)addColor:(UIColor *)color string:(NSString *)string
{
    [self.string rangesOfString:string
                     rangeBlock:^(NSRange range, NSInteger index) {
                         [self addColor:color range:range];
                     }];
}

- (void)addLineSpace:(CGFloat)space
{
    [self addLineSpace:space range:NSMakeRange(0, self.length)];
}

- (void)addLineSpace:(CGFloat)space range:(NSRange)range
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
