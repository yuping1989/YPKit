//
//  YPBaseCollectionViewController.m
//  HuoQiuJiZhang-debt
//
//  Created by 喻平 on 14/11/24.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import "YPBaseCollectionViewController.h"

@interface YPBaseCollectionViewController ()

@end

@implementation YPBaseCollectionViewController

@synthesize collectionViewDataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initCollectionViewDataSource {
    self.collectionViewDataSource = [[NSMutableArray alloc] init];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return collectionViewDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
    return cell;
}

@end
