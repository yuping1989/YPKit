//
//  UITextField+YPKit.m
//  YPKit
//
//  Created by 喻平 on 14-6-6.
//  Copyright (c) 2014年 com.yp All rights reserved.
//

#import "UITextField+YPKit.h"

@implementation UITextField (YPKit)

- (void)setTextPaddingLeft:(CGFloat)textPaddingLeft {
    if (!self.leftView) {
        self.leftView = [[UIView alloc] init];
    }
    self.leftView.frame = CGRectMake(0, 0, textPaddingLeft, self.bounds.size.height);
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (CGFloat)textPaddingLeft {
    return self.leftView.frame.size.width;
}

- (void)setTextPaddingRight:(CGFloat)textPaddingRight {
    if (!self.rightView) {
        self.rightView = [[UIView alloc] init];
    }
    self.rightView.frame = CGRectMake(0, 0, textPaddingRight, self.bounds.size.height);
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (CGFloat)textPaddingRight {
    return self.rightView.frame.size.width;
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
