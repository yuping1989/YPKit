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

@end
