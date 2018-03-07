//
//  UILabel+YPKit.m
//  YPKit
//
//  Created by 喻平 on 14-6-12.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import "UILabel+YPKit.h"
#import "NSAttributedString+YPKit.h"
#import "NSString+YPKit.h"
#import "UIView+YPKit.h"

@implementation UILabel (YPKit)
- (void)setText:(NSString *)text attributeString:(void(^)(NSMutableAttributedString *attrString))block {
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:text];
    if (block) {
        block(aString);
    }
    self.attributedText = aString;
}

#pragma mark - Methods should be deprecated

- (void)resizeToFitHeight:(BOOL)isAttributedText {
    self.numberOfLines = 0;
    if (isAttributedText) {
        self.yp_height = [self.attributedText heightWithWidth:self.yp_width];
    } else {
        self.yp_height = [self.text heightWithFont:self.font width:self.yp_width];
    }
}
- (void)resizeToFitWidth:(BOOL)isAttributedText {
    self.numberOfLines = 0;
    if (isAttributedText) {
        self.yp_width = self.attributedText.width;
    } else {
        self.yp_width = [self.text widthWithFont:self.font];
    }
}
@end
