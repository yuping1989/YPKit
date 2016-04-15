//
//  YPPlaceHolderTextView.m
//  NBD2
//
//  Created by 喻平 on 16/2/15.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import "YPPlaceHolderTextView.h"
@interface YPPlaceHolderTextView () {
    UITextView *_placeholderTextView;
}
@end

@implementation YPPlaceHolderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    if (_placeholderTextView == nil) {
        _placeholderTextView = [[UITextView alloc] initWithFrame:self.bounds];
        [self addSubview:_placeholderTextView];
        _placeholderTextView.userInteractionEnabled = NO;
        _placeholderTextView.backgroundColor = [UIColor clearColor];
        _placeholderTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _placeholderTextView.font = self.font;
        if (_placeholderColor) {
            _placeholderTextView.textColor = _placeholderColor;
        } else {
            _placeholderTextView.textColor = [UIColor lightGrayColor];
        }
    }
    _placeholderTextView.text = placeholder;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _placeholderTextView.font = font;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    _placeholderTextView.textColor = placeholderColor;
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    [super setTextContainerInset:textContainerInset];
    _placeholderTextView.textContainerInset = textContainerInset;
}

- (void)textDidChanged:(NSNotification *)notification {
    if (self.text.length == 0) {
        _placeholderTextView.hidden = NO;
    } else {
        _placeholderTextView.hidden = YES;
    }
    
}
@end
