//
//  UILabel+YPKit.m
//  YPKit
//
//  Created by 喻平 on 14-6-12.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import "UILabel+YPKit.h"

@implementation UILabel (YPKit)

- (void)setText:(NSString *)text makeAttribute:(void(^)(NSMutableAttributedString *attrStr))block {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    if (block) {
        block(string);
    }
    self.attributedText = string;
}

@end
