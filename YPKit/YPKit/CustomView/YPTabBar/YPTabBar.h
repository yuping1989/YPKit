//
//  YPTabBar.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YPTabBar;
@class YPTabItem;
@protocol YPTabBarDelegate <NSObject>
@optional
- (void)YPTabBar:(YPTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index;
- (BOOL)YPTabBar:(YPTabBar *)tabBar willSelectItemAtIndex:(NSInteger)index;
@end


@interface YPTabBar : UIView
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIImage *itemNormalBgImage;
@property (nonatomic, strong) UIImage *itemSelectedBgImage;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, assign) NSInteger selectedItemIndex;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) int spaceWidth;

@property (nonatomic, assign) id<YPTabBarDelegate> delegate;
- (void)itemCenterImageAndTitle:(int)spacing;
@end
