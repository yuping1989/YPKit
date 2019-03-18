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
@interface YPScaleHeaderVC ()


@end

@implementation YPScaleHeaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setScalableHeaderWithImage:nil defaultHeight:250 maskColor:nil];
    self.tableView.scalableHeaderImageView.backgroundColor = [UIColor lightGrayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [self addNotificationBlockForName:UIApplicationDidBecomeActiveNotification block:^(NSNotification * _Nonnull notification) {
        NSLog(@"hahaha");
    }];
    [self addNotificationBlockForName:UIApplicationDidBecomeActiveNotification block:^(NSNotification * _Nonnull notification) {
        NSLog(@"yyy");
    }];
}

- (void)dealloc {
    NSLog(@"sdf");
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
