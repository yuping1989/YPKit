//
//  YPBaseCollectionViewController.h
//  HuoQiuJiZhang-debt
//
//  Created by 喻平 on 14/11/24.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

@interface YPBaseCollectionViewController : YPBaseViewController <
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout> {
    
    NSMutableArray *collectionViewDataSource;
}

@property (nonatomic, strong) NSMutableArray *collectionViewDataSource;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

- (void)initCollectionViewDataSource;

@end
