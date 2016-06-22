//
//  YPSettingItem.m
//  ChangQingQuan
//
//  Created by 喻平 on 15/1/27.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import "YPSettingItem.h"
@interface YPSettingItem ()

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
    self.titleField.borderStyle = UITextBorderStyleNone;
    self.titleField.enabled = NO;
    [self addSubview:self.titleField];
    
    self.textField = [[UITextField alloc] init];
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.enabled = NO;
    self.textField.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.textField];
    
    _titleWidth = ceilf((SCREEN_WIDTH - 50) / 2);
    self.lineColor = [[YPSettingItem appearance] lineColor];
}

- (void)updateLayouts {
    
    CGFloat x = self.paddingLeft;
    CGFloat marginRight = self.paddingRight;
    if (self.leftImageView) {
        self.leftImageView.frame = CGRectMake(x, 0, self.leftImageWidth, self.height);
        x = self.leftImageView.maxX + 8;
    }
    
    self.titleField.frame = CGRectMake(x, 0, self.titleWidth, self.height);
    x = self.titleField.maxX + 8;
    
    if (self.arrowImageView) {
        self.arrowImageView.frame = CGRectMake(SCREEN_WIDTH - self.arrowImageView.image.size.width - marginRight,
                                               0,
                                               self.arrowImageView.image.size.width,
                                               self.height);
        marginRight = SCREEN_WIDTH - self.arrowImageView.x + 8;
        
    }
    if (self.rightImageView) {
        self.rightImageView.frame = CGRectMake(SCREEN_WIDTH - marginRight - self.rightImageView.image.size.width,
                                               0,
                                               self.rightImageView.image.size.width,
                                               self.height);
        marginRight = SCREEN_WIDTH - self.rightImageView.x + 8;
    }
    self.textField.frame = CGRectMake(x, 0, SCREEN_WIDTH - (x + marginRight), self.height);
}

#pragma mark - Title and Text

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleField.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleField.textColor = titleColor;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.titleField.font = titleFont;
}

- (void)setTitleWidth:(CGFloat)titleWidth {
    _titleWidth = titleWidth;
    [self updateLayouts];
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textField.text = text;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    self.textField.font = textFont;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.textField.textColor = textColor;
}

#pragma mark - Image

- (void)setLeftImage:(UIImage *)image {
    _leftImage = image;
    
    if (self.leftImageView == nil) {
        self.leftImageView = [[UIImageView alloc] init];
        self.leftImageView.contentMode = UIViewContentModeLeft;
        [self addSubview:self.leftImageView];
    }
    
    self.leftImageView.image = image;
    _leftImageWidth = MAX(_leftImageWidth, image.size.width);
    [self updateLayouts];
}

- (void)setLeftImageWidth:(CGFloat)leftImageWidth {
    _leftImageWidth = leftImageWidth;
    [self updateLayouts];
}

- (void)setRightImage:(UIImage *)image {
    _rightImage = image;
    if (self.rightImageView == nil) {
        self.rightImageView = [[UIImageView alloc] init];
        self.rightImageView.contentMode = UIViewContentModeRight;
        [self addSubview:self.rightImageView];
    }
    self.rightImageView.image = image;
    [self updateLayouts];
}

- (void)setArrowImage:(UIImage *)arrowImage {
    _arrowImage = arrowImage;
    if (arrowImage == nil) {
        [self.arrowImageView removeFromSuperview];
        self.arrowImageView = nil;
    } else {
        if (!self.arrowImageView) {
            self.arrowImageView = [[UIImageView alloc] init];
            self.arrowImageView.contentMode = UIViewContentModeCenter;
            [self addSubview:self.arrowImageView];
        }
        self.arrowImageView.image = arrowImage;
        self.arrowImageView.hidden = NO;
    }
    [self updateLayouts];
}

#pragma mark - Padding

- (void)setPaddingLeft:(CGFloat)paddingLeft {
    _paddingLeft = paddingLeft;
    [self updateLayouts];
}

- (void)setPaddingRight:(CGFloat)paddingRight {
    _paddingRight = paddingRight;
    [self updateLayouts];
}

#pragma mark - Style

- (void)setStyle:(YPSettingItemStyle)style {
    _style = style;
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

#pragma mark - Others

- (void)updateViewsWhenNightModelSwitched {
    self.titleField.textColor = [[YPSettingItem appearance] titleColor];
    self.textField.textColor = [[YPSettingItem appearance] textColor];
    self.backgroundColor = [[YPSettingItem appearance] backgroundColor];
    self.topLineLayer.backgroundColor = [[YPSettingItem appearance] lineColor].CGColor;
    self.bottomLineLayer.backgroundColor = [[YPSettingItem appearance] lineColor].CGColor;
}

@end
