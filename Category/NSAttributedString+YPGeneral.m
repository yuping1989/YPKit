//
//  NSAttributedString+YPGeneral.m
//  ChangQingQuan
//
//  Created by 喻平 on 15/3/31.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import "NSAttributedString+YPGeneral.h"

@implementation NSAttributedString (YPGeneral)
- (CGFloat)heightWithWidth:(CGFloat)width {
    return ceilf([self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    context:nil].size.height);
}
- (CGFloat)singleLineWidth {
    return ceilf([self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    context:nil].size.width);
}
@end
