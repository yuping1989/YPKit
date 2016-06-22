//
//  NSAttributedString+YPKit.m
//  ChangQingQuan
//
//  Created by 喻平 on 15/3/31.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import "NSAttributedString+YPKit.h"

@implementation NSAttributedString (YPKit)

- (CGFloat)heightWithWidth:(CGFloat)width {
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    context:nil].size.height;
}
- (CGFloat)width {
    
    return [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    context:nil].size.width;
}

@end
