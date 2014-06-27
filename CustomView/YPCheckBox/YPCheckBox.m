//
//  YPCheckBox.m
//  HuoQiuJiZhang
//
//  Created by 喻平 on 13-12-20.
//  Copyright (c) 2013年 com.huoqiu. All rights reserved.
//

#import "YPCheckBox.h"
#define Q_CHECK_ICON_WH                    (20.0)
#define Q_ICON_TITLE_MARGIN                (10.0)

@implementation YPCheckBox

+ (id)checkBoxWithFrame:(CGRect)frame
{
    YPCheckBox *checkBox = [YPCheckBox buttonWithType:UIButtonTypeCustom];
    checkBox.frame = frame;
    [checkBox setup];
    return checkBox;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    if ([self imageForState:UIControlStateNormal] == nil) {
        [self setImage:[UIImage imageNamed:@"checkbox_unchecked.png"] forState:UIControlStateNormal];
    }
    if ([self imageForState:UIControlStateSelected] == nil) {
        [self setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateSelected];
    }
    
    [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setChecked:(BOOL)checked {
    if (_checked == checked) {
        return;
    }
    _checked = checked;
    self.selected = checked;
}

- (void)checkboxBtnChecked {
    self.selected = !self.selected;
    _checked = self.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(ypCheckBox:stateDidChanged:)]) {
        [_delegate ypCheckBox:self stateDidChanged:self.selected];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, (CGRectGetHeight(contentRect) - Q_CHECK_ICON_WH)/2.0, Q_CHECK_ICON_WH, Q_CHECK_ICON_WH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(Q_CHECK_ICON_WH + Q_ICON_TITLE_MARGIN, 0,
                      CGRectGetWidth(contentRect) - Q_CHECK_ICON_WH - Q_ICON_TITLE_MARGIN,
                      CGRectGetHeight(contentRect));
}
@end
