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
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
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
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfPagesInPageControl:)]) {
        return [self.delegate numberOfPagesInPageControl:self];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YPPageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPPageViewCell" forIndexPath:indexPath];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(controlView:configurePageCell:forIndex:)]) {
        [self.delegate controlView:self configurePageCell:cell forIndex:indexPath.row];
    }
    [cell.imageButton addTarget:self action:@selector(imageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.imageButton.tag = indexPath.row;
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(controlView:displayingPageCellAtIndex:)]) {
        [self.delegate controlView:self displayingPageCellAtIndex:self.displayingIndex];
    }
}

- (void)reloadData {
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    self.displayingIndex = 0;
}

- (void)imageButtonClicked:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(controlView:didPageCellClickedAtIndex:)]) {
        [self.delegate controlView:self didPageCellClickedAtIndex:button.tag];
    }
}
@end
