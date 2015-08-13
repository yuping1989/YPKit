//
//  YPSettingItem.m
//  ChangQingQuan
//
//  Created by 喻平 on 15/1/27.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import "YPSettingItem.h"
@interface YPSettingItem ()

@property (nonatomic, strong) YPCompletionBlockWithData clickedHanlder;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@end
@implementation YPSettingItem
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.paddingLeft = 15;
        self.paddingRight = 15;
        self.leftImageWidth = 20;
        self.arrowImage = [[YPSettingItem appearance] placeholderArrowImage];
        
        self.titleField = [[UITextField alloc] init];
        _titleField.borderStyle = UITextBorderStyleNone;
        _titleField.textColor = [[YPSettingItem appearance] titleColor];
        _titleField.font = [[YPSettingItem appearance] titleFont];
        _titleField.enabled = NO;
        [self addSubview:_titleField];
        
        self.textField = [[UITextField alloc] init];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.textColor = [[YPSettingItem appearance] textColor];
        _textField.font = [[YPSettingItem appearance] textFont];
        _textField.enabled = NO;
        _textField.textAlignment = NSTextAlignmentRight;
        [self addSubview:_textField];
        
        self.titleWidth = ceilf((SCREEN_WIDTH - 50) / 2);
    }
    return self;
}

- (void)updateLayouts {
    if (_leftImageView) {
        _leftImageView.frame = CGRectMake(_paddingLeft, ceilf((self.height - _leftImageView.image.size.height) / 2),
                                          _leftImageWidth,
                                          _leftImageView.image.size.height);
    }
    if (_titleField) {
//        int width = [_titleField.text widthWithFont:_titleField.font];
        _titleField.frame = CGRectMake(_leftImageView == nil ? _paddingLeft : _leftImageView.maxX + 8,
                                       0, _titleWidth, self.height);
    }
    
    if (_arrowImageView) {
        _arrowImageView.frame = CGRectMake(SCREEN_WIDTH - _arrowImageView.image.size.width - _paddingRight,
                                           0,
                                          _arrowImageView.image.size.width,
                                          self.height);
    }
    if (_rightImageView) {
        _rightImageView.frame = CGRectMake(SCREEN_WIDTH - _paddingRight - (_arrowImageView == nil ? 0 : (_arrowImageView.image.size.    width + 8)) - 8 - _rightImageView.image.size.width,
                                           0,
                                           _rightImageView.image.size.width,
                                           self.height);
    }
    if (_textField) {
        float textX = _titleField.maxX + 8;
        _textField.frame = CGRectMake(textX,
                                      0,
                                      SCREEN_WIDTH - _paddingRight - (_arrowImageView == nil ? 0 : (_arrowImageView.image.size.width + 8)) - textX,
                                      self.height);
    }
}


- (void)setTitle:(NSString *)title {
    _titleField.text = title;
}

- (NSString *)title {
    return _titleField.text;
}

- (void)setTitleWidth:(float)titleWidth {
    _titleWidth = titleWidth;
    [self updateLayouts];
}

- (void)setText:(NSString *)text {
    
    _textField.text = text;
//    [self updateLayouts];
}

- (NSString *)text {
    return _textField.text;
}

- (void)setLeftImage:(UIImage *)image {
    if (_leftImageView == nil) {
        self.leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeLeft;
        [self addSubview:_leftImageView];
    }
    _leftImageView.image = image;
    [self updateLayouts];
}

- (UIImage *)leftImage {
    return _leftImageView.image;
}

- (void)setRightImage:(UIImage *)image {
    if (_rightImageView == nil) {
        self.rightImageView = [[UIImageView alloc] init];
        _rightImageView.contentMode = UIViewContentModeRight;
        [self addSubview:_rightImageView];
    }
    _rightImageView.image = image;
    [self updateLayouts];
}

- (UIImage *)rightImage {
    return _rightImageView.image;
}

- (void)setArrowImage:(UIImage *)image {
    if (image == nil) {
        [_arrowImageView removeFromSuperview];
        self.arrowImageView = nil;
        [self updateLayouts];
        return;
    }
    if (_arrowImageView == nil) {
        self.arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_arrowImageView];
    }
    _arrowImageView.image = image;
    
    [self updateLayouts];
}

- (UIImage *)arrowImage {
    return _arrowImageView.image;
}

- (void)setLeftImageWidth:(float)leftImageWidth {
    _leftImageWidth = leftImageWidth;
    [self updateLayouts];
}

- (void)setOnClickedHandler:(void (^)(YPSettingItem *item))clickedHanlder
{
    if (self.tapRecognizer == nil) {
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
        _tapRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:_tapRecognizer];
    }
    self.clickedHanlder = clickedHanlder;
}

- (void)handleSingleTap
{
    if (_clickedHanlder) {
        _clickedHanlder(self);
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.clickedHanlder) {
        self.backgroundColor = rgb(220, 220, 220);
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.clickedHanlder) {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.clickedHanlder) {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.clickedHanlder) {
        self.backgroundColor = [UIColor whiteColor];
    }
}
@end
