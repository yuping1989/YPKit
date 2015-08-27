//
//  NSMutableAttributedString+YPKit.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (YPKit)
- (void)addFont:(UIFont *)font range:(NSRange)range;
- (void)addColor:(UIColor *)color range:(NSRange)range;
- (void)addLineSpace:(float)space range:(NSRange)range;
- (void)addDeleteLineWithRange:(NSRange)range;


@end
