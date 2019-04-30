//
//  YPScaleHeaderVC.m
//  YPKit
//
//  Created by 喻平 on 2018/8/6.
//  Copyright © 2018年 YPKit. All rights reserved.
//

#import "YPScaleHeaderVC.h"
#import "UIScrollView+YPKit.h"
#import "NSObject+YPKit.h"
#import "UIImage+YPKit.h"
@interface YPScaleHeaderVC ()



@end

@implementation YPScaleHeaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    UIImage *image = [UIImage imageWithContentsOfFileName:@"header.jpg"];
    [self.tableView setScalableHeaderWithImage:image defaultHeight:250 imageViewInsets:UIEdgeInsetsMake(50, 10, 50, 10) maskColor:[UIColor colorWithWhite:0 alpha:0.5f]];
    
    self.tableView.yp_headerView.scalableImageView.backgroundColor = [UIColor lightGrayColor];
//    self.tableView.headerView.backgroundColor = [UIColor lightGrayColor];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [self addNotificationBlockForName:UIApplicationDidBecomeActiveNotification block:^(NSNotification * _Nonnull notification) {
        NSLog(@"hahaha");
    }];
    [self addNotificationBlockForName:UIApplicationDidBecomeActiveNotification block:^(NSNotification * _Nonnull notification) {
        NSLog(@"yyy");
    }];
    
    [self.tableView addBlockObserver:self forKeyPath:@"contentOffset" block:^(__weak id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
        NSLog(@"new-->%@", newVal);
    }];
}

- (void)dealloc {
    NSLog(@"sadf");
//    [self.tableView removeBlockObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"become");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
