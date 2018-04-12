//
//  YPCheckBox.m
//  HuoQiuJiZhang
//
//  Created by 喻平 on 13-12-20.
//  Copyright (c) 2013年 com.huoqiu. All rights reserved.
//

#import "YPCheckBox.h"

@implementation YPCheckBox

+ (id)checkBoxWithFrame:(CGRect)frame {
    YPCheckBox *checkBox = [YPCheckBox buttonWithType:UIButtonTypeCustom];
    checkBox.frame = frame;
    [checkBox setup];
    return checkBox;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    if (![self imageForState:UIControlStateNormal]) {
        if ([[YPCheckBox appearance] normalImage]) {
            [self setImage:[[YPCheckBox appearance] normalImage] forState:UIControlStateNormal];
        }
        if ([[YPCheckBox appearance] checkedImage]) {
            [self setImage:[[YPCheckBox appearance] checkedImage] forState:UIControlStateSelected];
        }
    }
    
    if ([self titleForState:UIControlStateNormal]) {
        if (_spacingInImageAndTitle == 0) {
            _spacingInImageAndTitle = 8;
        }
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateSubviews {
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentLeft:
            self.titleEdgeInsets = UIEdgeInsetsMake(0, self.imageMarginLeft + self.spacingInImageAndTitle, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, self.imageMarginLeft, 0, 0);
            break;
        case UIControlContentHorizontalAlignmentCenter: {
            BOOL hasTitle = [self titleForState:UIControlStateNormal].length > 0;
            self.titleEdgeInsets = UIEdgeInsetsMake(0, self.spacingInImageAndTitle, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, hasTitle ? -self.spacingInImageAndTitle : 0, 0, 0);
            break;
        }
        case UIControlContentHorizontalAlignmentRight:
            self.titleEdgeInsets = UIEdgeInsetsZero;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, self.spacingInImageAndTitle);
            break;
        default:
            break;
    }
}

- (void)setSpacingInImageAndTitle:(CGFloat)spacingInImageAndTitle {
    _spacingInImageAndTitle = spacingInImageAndTitle;
    [self updateSubviews];
}

- (void)setImageMarginLeft:(CGFloat)imageMarginLeft {
    _imageMarginLeft = imageMarginLeft;
    [self updateSubviews];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    if (title.length > 0) {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    } else {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
}

- (void)setContentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment {
    [super setContentHorizontalAlignment:contentHorizontalAlignment];
    [self updateSubviews];
}

- (void)setNormalImage:(UIImage *)normalImage checkedImage:(UIImage *)checkedImage {
    [self setImage:normalImage forState:UIControlStateNormal];
    [self setImage:checkedImage forState:UIControlStateSelected];
}


- (void)setChecked:(BOOL)checked {
    if (_checked == checked) {
        return;
    }
    _checked = checked;
    self.selected = checked;
}

- (void)checkboxBtnChecked {
    
    if (_delegate && [_delegate respondsToSelector:@selector(ypCheckBox:stateWillChange:)]) {
        if (![_delegate ypCheckBox:self stateWillChange:!self.checked]) {
            return;
        }
    }
    self.checked = !self.checked;
    if (_delegate && [_delegate respondsToSelector:@selector(ypCheckBox:stateDidChanged:)]) {
        [_delegate ypCheckBox:self stateDidChanged:self.checked];
    }
    if (self.stateChangedBlock) {
        self.stateChangedBlock(self.checked);
    }
}

@end
