//
//  YPPlaceHolderTextView.m
//  NBD2
//
//  Created by 喻平 on 16/2/15.
//  Copyright © 2016年 NBD2. All rights reserved.
//

#import "YPPlaceHolderTextView.h"
@interface YPPlaceHolderTextView ()

@property (nonatomic, strong) UITextView *placeholderTextView;

@end

@implementation YPPlaceHolderTextView

- (instancetype)initWithFrame:(CGRect)frame {
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
    if (!self.placeholderTextView) {
        self.placeholderTextView = [[UITextView alloc] initWithFrame:self.bounds];
        [self addSubview:self.placeholderTextView];
        self.placeholderTextView.userInteractionEnabled = NO;
        self.placeholderTextView.backgroundColor = [UIColor clearColor];
        self.placeholderTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.placeholderTextView.font = self.font;
        if (self.placeholderColor) {
            self.placeholderTextView.textColor = _placeholderColor;
        } else {
            self.placeholderTextView.textColor = [UIColor lightGrayColor];
        }
    }
    self.placeholderTextView.text = placeholder;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholderTextView.font = font;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.placeholderTextView.textColor = placeholderColor;
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    [super setTextContainerInset:textContainerInset];
    self.placeholderTextView.textContainerInset = textContainerInset;
}

- (void)textDidChanged:(NSNotification *)notification {
    if (self.text.length == 0) {
        self.placeholderTextView.hidden = NO;
    } else {
        self.placeholderTextView.hidden = YES;
    }
}

@end
