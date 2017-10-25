//
//  NSMutableAttributedString+YPKit.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (YPKit)

- (void)addFont:(UIFont *)font;
- (void)addFont:(UIFont *)font range:(NSRange)range;
- (void)addFont:(UIFont *)font string:(NSString *)string;

- (void)addColor:(UIColor *)color;
- (void)addColor:(UIColor *)color range:(NSRange)range;
- (void)addColor:(UIColor *)color string:(NSString *)string;

- (void)addLineSpace:(CGFloat)space;
- (void)addLineSpace:(CGFloat)space range:(NSRange)range;
- (void)addLineSpace:(CGFloat)space string:(NSString *)string;

- (void)addDeleteLineWithRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
