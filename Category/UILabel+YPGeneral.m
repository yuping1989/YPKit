//
//  UILabel+YPGeneral.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "UILabel+YPGeneral.h"

@implementation UILabel (YPGeneral)
- (void)setText:(NSString *)text attributeString:(void(^)(NSMutableAttributedString *attrString))block
{
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:text];
    if (block) {
        block(aString);
    }
    self.attributedText = aString;
}

- (void)resizeToFitHeight
{
    self.numberOfLines = 0;
    self.height = [self.text heightWithFont:self.font width:self.width];
}
- (void)resizeToFitWidth
{
    self.numberOfLines = 0;
    self.width = ceilf([self.text sizeWithFont:self.font].width);
}
@end
