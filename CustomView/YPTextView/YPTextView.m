//
//  YPTextView.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-6-17.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "YPTextView.h"
@interface YPTextView ()
{
    UILabel *_placeholderLabel;
    UIImageView *_backgroudnImageView;
    int _height;
}
@end
@implementation YPTextView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initialize];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    return self;
}


- (id)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    
    return self;
}


- (void)initialize
{
    _placeholderColor = [UIColor lightGrayColor];
    [self layoutGUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
    
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification center


- (void)textChanged:(NSNotification *)notification
{
    if (notification.object == self) {
        [self layoutGUI];
        NSLog(@"content size-->%@", NSStringFromCGSize(self.contentSize));
        if (_height == 0) {
            _height = self.contentSize.height;
            return;
        }
        if (_height != self.contentSize.height) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(ypTextView:didContentHeightChanged:)]) {
                [self.delegate ypTextView:self didContentHeightChanged:self.contentSize.height - _height];
            }
            _height = self.contentSize.height;
        }
    }
}


#pragma mark - layoutGUI


- (void)layoutGUI
{
    _placeholderLabel.alpha = [self.text length] > 0 || [_placeholderText length] == 0 ? 0 : 1;
}


#pragma mark - Setters


- (void)setText:(NSString *)text
{
    [super setText:text];
    [self layoutGUI];
}


- (void)setPlaceholderText:(NSString*)placeholderText
{
	_placeholderText = placeholderText;
	[self setNeedsDisplay];
}


- (void)setPlaceholderColor:(UIColor*)color
{
	_placeholderColor = color;
	[self setNeedsDisplay];
}


#pragma mark - drawRect


- (void)drawRect:(CGRect)rect
{
    if ([_placeholderText length] > 0)
    {
        if (!_placeholderLabel)
        {
            _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.bounds.size.width - 16, 0)];
            _placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeholderLabel.numberOfLines = 0;
            _placeholderLabel.font = self.font;
            _placeholderLabel.backgroundColor = [UIColor clearColor];
            _placeholderLabel.alpha = 0;
            [self addSubview:_placeholderLabel];
        }
        
        _placeholderLabel.text = _placeholderText;
        _placeholderLabel.textColor = _placeholderColor;
        [_placeholderLabel sizeToFit];
        [self sendSubviewToBack:_placeholderLabel];
    }
    
    [self layoutGUI];
    
    [super drawRect:rect];
}
@end
