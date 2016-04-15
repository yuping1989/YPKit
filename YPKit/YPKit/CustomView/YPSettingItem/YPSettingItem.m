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
    self.titleField = [[UITextField alloc] init];
    _titleField.borderStyle = UITextBorderStyleNone;
    _titleField.enabled = NO;
    [self addSubview:_titleField];
    
    self.textField = [[UITextField alloc] init];
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.enabled = NO;
    _textField.textAlignment = NSTextAlignmentRight;
    [self addSubview:_textField];
    
    self.arrowImageView = [[UIImageView alloc] init];
    _arrowImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_arrowImageView];
    
    _titleWidth = ceilf((SCREEN_WIDTH - 50) / 2);
    self.lineColor = [[YPSettingItem appearance] lineColor];
}

- (void)updateLayouts {
    if (_leftImageView) {
        _leftImageView.frame = CGRectMake(_paddingLeft, ceilf((self.height - _leftImageView.image.size.height) / 2),
                                          _leftImageWidth,
                                          _leftImageView.image.size.height);
    }
    if (_titleField) {
        _titleField.frame = CGRectMake(_leftImageView == nil ? _paddingLeft : _paddingLeft + _leftImageView.maxX + 8,
                                       0, _titleWidth, self.height);
    }
    
    if (!_arrowImageView.hidden) {
        _arrowImageView.frame = CGRectMake(SCREEN_WIDTH - _arrowImageView.image.size.width - _paddingRight,
                                           0,
                                          _arrowImageView.image.size.width,
                                          self.height);
    }
    if (_rightImageView) {
        _rightImageView.frame = CGRectMake(SCREEN_WIDTH - _paddingRight - (_arrowImageView == nil ? 0 : (_arrowImageView.image.size.width + 8)) - 8 - _rightImageView.image.size.width,
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

- (void)setStyle:(YPSettingItemStyle)style {
    _style = style;
    if (self.topLineLayer) {
        [self.topLineLayer removeFromSuperlayer];
        self.topLineLayer = nil;
    }
    if (self.bottomLineLayer) {
        [self.bottomLineLayer removeFromSuperlayer];
        self.bottomLineLayer = nil;
    }
    if (_style == YPSettingItemStyleTop) {
        [self setTopFillLineWithColor:self.lineColor];
        [self setBottomLineWithColor:self.lineColor paddingLeft:[[YPSettingItem appearance] paddingLeft]];
    } else if (_style == YPSettingItemStyleCenter) {
        [self setBottomLineWithColor:self.lineColor paddingLeft:[[YPSettingItem appearance] paddingLeft]];
    } else if (_style == YPSettingItemStyleBottom) {
        [self setBottomFillLineWithColor:self.lineColor];
    } else if (_style == YPSettingItemStyleSingle) {
        [self setTopFillLineWithColor:self.lineColor];
        [self setBottomFillLineWithColor:self.lineColor];
    }
}

- (void)topStyle {
    self.style = YPSettingItemStyleTop;
}
- (void)bottomStyle {
    self.style = YPSettingItemStyleBottom;
}
- (void)centerStyle {
    self.style = YPSettingItemStyleCenter;
}
- (void)singleStyle {
    self.style = YPSettingItemStyleSingle;
}
- (void)setPaddingLeft:(float)paddingLeft {
    _paddingLeft = paddingLeft;
    [self updateLayouts];
}

- (void)setPaddingRight:(float)paddingRight {
    _paddingRight = paddingRight;
    [self updateLayouts];
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

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    _titleField.font = titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleField.textColor = titleColor;
}

- (void)setText:(NSString *)text {
    _textField.text = text;
}

- (NSString *)text {
    return _textField.text;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    _textField.font = textFont;
}
- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _textField.textColor = textColor;
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

- (void)setArrowImage:(UIImage *)arrowImage {
    _arrowImage = arrowImage;
    if (arrowImage == nil) {
        _arrowImageView.hidden = YES;
    } else {
        _arrowImageView.image = arrowImage;
        _arrowImageView.hidden = NO;
    }
    [self updateLayouts];
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
        self.backgroundColor = RGB(220, 220, 220);
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.clickedHanlder) {
        self.backgroundColor = [[YPSettingItem appearance] backgroundColor];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.clickedHanlder) {
        self.backgroundColor = [[YPSettingItem appearance] backgroundColor];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.clickedHanlder) {
        self.backgroundColor = [[YPSettingItem appearance] backgroundColor];
    }
}

- (void)updateViewsWhenNightModelSwitched {
    self.titleField.textColor = [[YPSettingItem appearance] titleColor];
    self.textField.textColor = [[YPSettingItem appearance] textColor];
    self.backgroundColor = [[YPSettingItem appearance] backgroundColor];
    self.topLineLayer.backgroundColor = [[YPSettingItem appearance] lineColor].CGColor;
    self.bottomLineLayer.backgroundColor = [[YPSettingItem appearance] lineColor].CGColor;
}
@end
