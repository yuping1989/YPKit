//
//  YPPageView.m
//  NBD2
//
//  Created by 喻平 on 15/11/16.
//  Copyright © 2015年 NBD2. All rights reserved.
//

#import "YPPageView.h"
#import "YPPageViewCell.h"

@interface YPPageView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation YPPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollsToTop = NO;
    self.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YPPageViewCell" bundle:nil]
          forCellWithReuseIdentifier:@"YPPageViewCell"];
    [self insertSubview:self.collectionView atIndex:0];
    
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(yp_numberOfPagesInPageView:)]) {
        return [self.delegate yp_numberOfPagesInPageView:self];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(yp_pageView:cellForItemAtIndex:)]) {
        return [self.delegate yp_pageView:self cellForItemAtIndex:indexPath.row];
    }
    YPPageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPPageViewCell" forIndexPath:indexPath];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(yp_pageView:configurePageCell:forIndex:)]) {
        [self.delegate yp_pageView:self configurePageCell:cell forIndex:indexPath.row];
    }
    [cell.imageButton addTarget:self action:@selector(imageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.imageButton.tag = indexPath.row;
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (page == self.displayingIndex) {
        return;
    }
    NSLog(@"page--->%ld", page);
    self.displayingIndex = page;
}

- (void)setDisplayingIndex:(NSInteger)displayingIndex {
    _displayingIndex = displayingIndex;
    if (self.delegate && [self.delegate respondsToSelector:@selector(yp_pageView:didEndDisplayingPageCellAtIndex:)]) {
        [self.delegate yp_pageView:self didEndDisplayingPageCellAtIndex:self.displayingIndex];
    }
}

- (void)reloadData {
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    self.displayingIndex = 0;
}

- (void)imageButtonClicked:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(yp_pageView:didClickPageCellAtIndex:)]) {
        [self.delegate yp_pageView:self didClickPageCellAtIndex:button.tag];
    }
}

@end
