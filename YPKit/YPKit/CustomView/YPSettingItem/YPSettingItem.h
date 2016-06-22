//
//  YPSettingItem.h
//  ChangQingQuan
//
//  Created by 喻平 on 15/1/27.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPControl.h"

typedef NS_ENUM(NSInteger, YPSettingItemStyle) {
    YPSettingItemStyleTop,
    YPSettingItemStyleCenter,
    YPSettingItemStyleBottom,
    YPSettingItemStyleSingle
};

@interface YPSettingItem : YPControl

@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat titleWidth UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIImage *leftImage;
@property (nonatomic, assign) CGFloat leftImageWidth UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIImage *rightImage;
@property (nonatomic, strong) UIImage *arrowImage UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGFloat paddingLeft UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat paddingRight UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *lineColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) YPSettingItemStyle style;
- (void)topStyle;
- (void)bottomStyle;
- (void)centerStyle;
- (void)singleStyle;

- (void)updateLayouts;

//@property (nonatomic, copy) void (^onClickedHandler)(YPSettingItem *item);

- (void)updateViewsWhenNightModelSwitched;

@end
