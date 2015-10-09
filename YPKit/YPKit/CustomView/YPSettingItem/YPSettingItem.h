//
//  YPSettingItem.h
//  ChangQingQuan
//
//  Created by 喻平 on 15/1/27.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, YPSettingItemType) {
    YPSettingItemTypeTop,
    YPSettingItemTypeCenter,
    YPSettingItemTypeBottom
};
@interface YPSettingItem : UIView
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) CALayer *topLineLayer;
@property (nonatomic, strong) CALayer *bottomLineLayer;

@property (nonatomic, assign) float titleWidth;
@property (nonatomic, assign) YPSettingItemType type;

@property (nonatomic, assign) float paddingLeft UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) float paddingRight UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) float leftImageWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *titleColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIImage *arrowImage UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *lineColor UI_APPEARANCE_SELECTOR;

- (void)setOnClickedHandler:(void (^)(YPSettingItem *item))clickedHanlder;

- (void)updateLayouts;

- (void)setTitle:(NSString *)title;
- (NSString *)title;

- (void)setText:(NSString *)text;
- (NSString *)text;

- (void)setLeftImage:(UIImage *)image;
- (UIImage *)leftImage;

- (void)setRightImage:(UIImage *)image;
- (UIImage *)rightImage;


@end
