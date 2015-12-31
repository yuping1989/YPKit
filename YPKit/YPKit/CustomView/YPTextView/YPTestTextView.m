//
//  YPTestTextView.m
//  GCLibrary
//
//  Created by Guillaume Campagna on 10-11-16.
//  Copyright 2010 LittleKiwi. All rights reserved.
//

#import "YPTestTextView.h"

@interface YPTestTextView ()

@property (nonatomic, strong) UITextView *placeholderTextView;
- (void)beginEditing:(NSNotification*)notification;
- (void)endEditing:(NSNotification*)notification;

@end

@implementation YPTestTextView
@dynamic delegate;
#pragma mark -
#pragma mark Initialisation

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}



- (void)awakeFromNib {
    NSLog(@"awakeFromNib");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _placeholderTextView.font = font;
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    [super setTextContainerInset:textContainerInset];
    _placeholderTextView.textContainerInset = textContainerInset;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _placeholderTextView.frame = self.bounds;
}

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
    if (self.delegate && [self.delegate respondsToSelector:@selector(yp_textView:didContentHeightChanged:)]) {
        [super setContentOffset:contentOffset animated:NO];
    } else {
        [super setContentOffset:contentOffset animated:animated];
    }
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    if (self.placeholderTextView == nil) {
        self.placeholderTextView = [[UITextView alloc] initWithFrame:self.bounds];
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

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    _placeholderTextView.textColor = placeholderColor;
}

- (void)beginEditing:(NSNotification*) notification {
    _placeholderTextView.hidden = YES;
    self.contentOffset = CGPointMake(self.contentOffset.x, (self.contentSize.height - self.height) / 2);
}

- (void)endEditing:(NSNotification*) notification {
    if (self.text.length == 0) {
        _placeholderTextView.hidden = NO;
    }
}

- (void)textChanged:(NSNotification *)notification {
    NSLog(@"content size-->%@", NSStringFromCGSize(self.contentSize));
    NSLog(@"content offset--->%@", NSStringFromCGPoint(self.contentOffset));
    if (self.delegate && [self.delegate respondsToSelector:@selector(yp_textView:didContentHeightChanged:)]) {
        NSInteger height;
        if (_maxHeight > 0 && self.contentSize.height > _maxHeight) {
            height = ceilf(_maxHeight - self.height);
        } else {
            height = ceilf(self.contentSize.height - self.height);
        }
        if (height != 0) {
            [self.delegate yp_textView:self didContentHeightChanged:height];
        }
    }
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
