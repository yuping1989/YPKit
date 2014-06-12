//
//  NSMutableAttributedString+YPGeneral.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (YPGeneral)
- (void)addFont:(UIFont *)font range:(NSRange)rage;
- (void)addColor:(UIColor *)color range:(NSRange)rage;
@end
