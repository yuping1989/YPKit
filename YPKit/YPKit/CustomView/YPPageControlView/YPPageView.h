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
- (NSInteger)numberOfPagesInPageControl:(YPPageView *)pageView;

@optional
- (void)controlView:(YPPageView *)pageView
  configurePageCell:(YPPageViewCell *)cell
           forIndex:(NSInteger)index;
- (void)controlView:(YPPageView *)pageView displayingPageCellAtIndex:(NSInteger)index;
- (void)controlView:(YPPageView *)pageView didPageCellClickedAtIndex:(NSInteger)index;
@end

@interface YPPageView : UIView
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *dataSourceArray;
@property (nonatomic, assign) IBOutlet id<YPPageViewDelegate> delegate;
@property (nonatomic, assign) NSInteger displayingIndex;
- (void)reloadData;
@end
