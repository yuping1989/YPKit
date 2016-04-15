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


- (void)awakeFromNib {
    [self setup];
}

- (void)setup
{
    if ([self imageForState:UIControlStateNormal] == nil) {
        if ([[YPCheckBox appearance] normalImage]) {
            [self setImage:[[YPCheckBox appearance] normalImage] forState:UIControlStateNormal];
        }
        if ([[YPCheckBox appearance] checkedImage]) {
            [self setImage:[[YPCheckBox appearance] checkedImage] forState:UIControlStateSelected];
        }
    }
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
}


- (void)setNormalImage:(UIImage *)normalImage checkedImage:(UIImage *)checkedImage
{
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
}

//- (CGRect)imageRectForContentRect:(CGRect)contentRect {
//    NSLog(@"imageRectForContentRect");
//    return CGRectMake(0, (CGRectGetHeight(contentRect) - Q_CHECK_ICON_WH)/2.0, Q_CHECK_ICON_WH, Q_CHECK_ICON_WH);
//}
//
//- (CGRect)titleRectForContentRect:(CGRect)contentRect {
//    return CGRectMake(Q_CHECK_ICON_WH + Q_ICON_TITLE_MARGIN, 0,
//                      CGRectGetWidth(contentRect) - Q_CHECK_ICON_WH - Q_ICON_TITLE_MARGIN,
//                      CGRectGetHeight(contentRect));
//}
@end
