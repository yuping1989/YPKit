//
//  YPPageView.h
//  NBD2
//
//  Created by 喻平 on 15/11/16.
//  Copyright © 2015年 NBD2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPPageViewCell.h"

@class YPPageView;

@protocol YPPageViewDelegate <NSObject>

- (NSInteger)yp_numberOfPagesInPageView:(YPPageView *)pageView;

@optional

/**
 *  配置page cell，cell为自己创建
 */
- (UICollectionViewCell *)yp_pageView:(YPPageView *)pageView cellForItemAtIndex:(NSInteger)index;

/**
 *  配置page cell，cell已被创建，只能修改。如果实现了pageView:cellForItemAtIndex:方法，此方法无效
 */
- (void)yp_pageView:(YPPageView *)pageView configurePageCell:(YPPageViewCell *)cell forIndex:(NSInteger)index;

/**
 *  page被展示时回调
 */
- (void)yp_pageView:(YPPageView *)pageView didDisplayPageCellAtIndex:(NSInteger)index;

/**
 *  cell被点击时回调
 */
- (void)yp_pageView:(YPPageView *)pageView didClickPageCellAtIndex:(NSInteger)index;

@end

@interface YPPageView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger displayingIndex;

@property (nonatomic, weak) IBOutlet id<YPPageViewDelegate> delegate;

- (void)reloadData;

@end
