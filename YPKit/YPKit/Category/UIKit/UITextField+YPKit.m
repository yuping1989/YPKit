//
//  UITextField+YPKit.m
//  YPKit
//
//  Created by 喻平 on 14-6-6.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import "UITextField+YPKit.h"
#import "UIView+YPKit.h"

@implementation UITextField (YPKit)

- (void)setContentPaddingLeft:(CGFloat)width {
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.yp_height)];
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setContentPaddingRight:(CGFloat)width {
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.yp_height)];
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (void)setText:(NSString *)text attributeString:(void(^)(NSMutableAttributedString *attrString))block {
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:text];
    if (block) {
        block(aString);
    }
    self.attributedText = aString;
}

- (void)hideInputAssistantItem {
    if (@available(iOS 9.0, *)) {
        UITextInputAssistantItem *inputAssistantItem = [self inputAssistantItem];
        inputAssistantItem.leadingBarButtonGroups = @[];
        inputAssistantItem.trailingBarButtonGroups = @[];
    }
}

- (void)setPlaceholder:(NSString *)placeholder withColor:(UIColor *)color {
    if (!placeholder || !color) {
        return;
    }
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder
                                                                 attributes:@{NSForegroundColorAttributeName : color}];
}

@end
