//
//  YPTabBar.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "YPTabBar.h"
#import "YPTabItem.h"

@interface YPTabBar ()
@property (nonatomic, strong) UIImageView *bgImageView;

@end


@implementation YPTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_bgImageView];
        _selectedItemIndex = -1;
    }
    return self;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    float x = 0;
    float width = self.width / _items.count;
    for (int i = 0; i < _items.count; i++) {
        YPTabItem *item = _items[i];
        item.frame = CGRectMake(x, 0, width, self.height);
        item.index = i;
        [item addTarget:self action:@selector(tabItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        x += width;
    }
}
- (void)setTitleNormalColor:(UIColor *)titleNormalColor
{
    _titleNormalColor = titleNormalColor;
    for (YPTabItem *item in _items) {
        [item setTitleColor:_titleNormalColor forState:UIControlStateNormal];
    }
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor
{
    _titleSelectedColor = titleSelectedColor;
    for (YPTabItem *item in _items) {
        [item setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
    }
}

- (void)setItemSelectedBgImage:(UIImage *)itemSelectedBgImage
{
    _itemSelectedBgImage = itemSelectedBgImage;
    for (YPTabItem *item in _items) {
        [item setBackgroundImage:_itemSelectedBgImage forState:UIControlStateSelected];
    }
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    for (YPTabItem *item in _items) {
        item.titleLabel.font = titleFont;
    }
}

- (void)itemCenterImageAndTitle:(int)spacing
{
    for (YPTabItem *item in _items) {
        [item centerImageAndTitle:spacing];
    }
}

- (void)setSelectedItemIndex:(NSInteger)selectedItemIndex
{
    BOOL will = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(YPTabBar:willSelectItemAtIndex:)]) {
        will = [_delegate YPTabBar:self willSelectItemAtIndex:selectedItemIndex];
    }
    if (will == YES) {
        _selectedItemIndex = selectedItemIndex;
        if (_delegate && [_delegate respondsToSelector:@selector(YPTabBar:didSelectItemAtIndex:)]) {
            [_delegate YPTabBar:self didSelectItemAtIndex:selectedItemIndex];
        }
    }
}

- (void)tabItemClicked:(YPTabItem *)item
{
    NSLog(@"_selectedItemIndex-->%d", _selectedItemIndex);
    self.selectedItemIndex = item.index;
}
- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    _bgImageView.image = backgroundImage;
}
@end
