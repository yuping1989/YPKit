//
//  UILabel+YPKit.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-12.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "UILabel+YPKit.h"

@implementation UILabel (YPKit)
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
    if (self.attributedText) {
        self.height = [self.attributedText heightWithWidth:self.width];
    } else {
        
        self.height = [self.text heightWithFont:self.font width:self.width];
    }
}
- (void)resizeToFitWidth
{
    self.numberOfLines = 0;
    if (self.attributedText) {
        self.width = self.attributedText.width;
    } else {
        self.width = [self.text widthWithFont:self.font];
    }
}
@end
