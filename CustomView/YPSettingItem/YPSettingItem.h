//
//  YPSettingItem.h
//  ChangQingQuan
//
//  Created by 喻平 on 15/1/27.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPSettingItem : UIView
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, assign) float paddingLeft;
@property (nonatomic, assign) float paddingRight;

@property (nonatomic, assign) float leftImageWidth;
@property (nonatomic, assign) float titleWidth;

@property (nonatomic, strong) UIColor *titleColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIImage *placeholderArrowImage UI_APPEARANCE_SELECTOR;

- (void)setClickedHandler:(void (^)(YPSettingItem *item))clickedHanlder;

- (void)updateLayouts;

- (void)setTitle:(NSString *)title;
- (NSString *)title;

- (void)setText:(NSString *)text;
- (NSString *)text;

- (void)setLeftImage:(UIImage *)image;
- (UIImage *)leftImage;

- (void)setRightImage:(UIImage *)image;
- (UIImage *)rightImage;

- (void)setArrowImage:(UIImage *)image;
- (UIImage *)arrowImage;
@end
