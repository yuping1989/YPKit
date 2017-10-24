//
//  NSAttributedString+YPKit.m
//  ChangQingQuan
//
//  Created by 喻平 on 15/3/31.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import "NSAttributedString+YPKit.h"

@implementation NSAttributedString (YPKit)

- (NSRange)rangeOfAll {
    return NSMakeRange(0, self.length);
}

- (CGFloat)heightWithWidth:(CGFloat)width {
    return ceilf([self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    context:nil].size.height);
}

- (CGFloat)width {
    
    return ceilf([self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    context:nil].size.width);
}

@end
