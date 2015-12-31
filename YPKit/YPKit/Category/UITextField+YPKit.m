//
//  UITextField+YPKit.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-6.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "UITextField+YPKit.h"

@implementation UITextField (YPKit)
- (void)setContentPaddingLeft:(CGFloat)width
{
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.height)];
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setText:(NSString *)text attributeString:(void(^)(NSMutableAttributedString *attrString))block
{
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:text];
    if (block) {
        block(aString);
    }
    self.attributedText = aString;
}

- (void)hideInputAssistantItem {
    if ([self respondsToSelector:@selector(inputAssistantItem)]) {
        UITextInputAssistantItem *inputAssistantItem = [self inputAssistantItem];
        inputAssistantItem.leadingBarButtonGroups = @[];
        inputAssistantItem.trailingBarButtonGroups = @[];
    }
}
@end
