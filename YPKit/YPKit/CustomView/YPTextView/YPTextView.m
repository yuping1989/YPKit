//
//  YPTextView.m
//  YPKit
//
//  Created by 喻平 on 15/12/3.
//  Copyright © 2015年 YPKit. All rights reserved.
//

#import "YPTextView.h"

@interface YPTextView ()

@property (nonatomic, assign) BOOL layoutFinished;
@property (nonatomic, assign) CGFloat defaultHeight;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;

@end

@implementation YPTextView
@dynamic delegate;

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layoutFinished = YES;
}

- (void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    if (!self.dynamicHeightEnabled) {
        return;
    }
    // 监听size变化
    if (self.font) {
        if (self.layoutFinished) { // 更新约束或者大小
            CGFloat fitHeight = MAX(self.contentSize.height, self.defaultHeight);

            if (fabs(fitHeight - self.bounds.size.height) < self.font.lineHeight * 0.5) { // 变化量小于一个行距的0.5倍
                [self findHeightConstraint];
                return;
            }
            if (fitHeight > self.maxHeight) {
                return;
            }
            [UIView animateWithDuration:self.heigthChangedAnimateDuration animations:^{
                if (self.heightConstraint) {
                    self.heightConstraint.constant = fitHeight;
                    [self layoutIfNeeded];
                    [self.superview layoutIfNeeded];
                }
                if (self.delegate && [self.delegate respondsToSelector:@selector(textView:didContentHeightChanged:)]) {
                    [self.delegate textView:self didContentHeightChanged:fitHeight];
                }
            }];
        } else { // 查找height约束，记录初值
            [self findHeightConstraint];
        }
    }
}

- (void)findHeightConstraint {
    if (self.heightConstraint || self.defaultHeight > 0.0f) {
        return;
    }
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.secondItem == nil && constraint.firstAttribute == NSLayoutAttributeHeight) {
            self.heightConstraint = constraint;
            self.defaultHeight = self.heightConstraint.constant;
            return;
        }
    }
    self.defaultHeight = self.bounds.size.height;
}

@end
