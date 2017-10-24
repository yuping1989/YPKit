//
//  NSMutableAttributedString+YPKit.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "NSMutableAttributedString+YPKit.h"
#import "NSString+YPKit.h"
#import "NSAttributedString+YPKit.h"

@implementation NSMutableAttributedString (YPKit)


- (void)addFont:(UIFont *)font {
    [self addFont:font range:self.rangeOfAll];
}

- (void)addFont:(UIFont *)font range:(NSRange)range {
    [self addAttribute:NSFontAttributeName value:font range:range];
}

- (void)addFont:(UIFont *)font string:(NSString *)string {
    [self.string enumerateRangesOfString:string
                              usingBlock:^(NSRange range, NSInteger index) {
                                  [self addFont:font range:range];
                              }];
}

- (void)addColor:(UIColor *)color {
    [self addColor:color range:self.string.rangeOfAll];
}

- (void)addColor:(UIColor *)color range:(NSRange)range {
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)addColor:(UIColor *)color string:(NSString *)string {
    [self.string enumerateRangesOfString:string
                              usingBlock:^(NSRange range, NSInteger index) {
                                  [self addColor:color range:range];
                              }];
}

- (void)addLineSpace:(CGFloat)space {
    [self addLineSpace:space range:self.rangeOfAll];
}

- (void)addLineSpace:(CGFloat)space range:(NSRange)range {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:space];
    [self addAttribute:NSParagraphStyleAttributeName
                 value:style
                 range:range];
}

- (void)addLineSpace:(CGFloat)space string:(NSString *)string {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:space];
    [self.string enumerateRangesOfString:string
                              usingBlock:^(NSRange range, NSInteger index) {
                                  [self addLineSpace:space range:range];
                              }];
}

- (void)addDeleteLineWithRange:(NSRange)range {
    [self addAttribute:NSStrikethroughStyleAttributeName
                 value:@(NSUnderlineStyleSingle)
                 range:range];
}

@end
