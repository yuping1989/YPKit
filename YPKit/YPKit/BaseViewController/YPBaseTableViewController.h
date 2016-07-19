//
//  YPBaseTableViewController.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-7-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPBaseTableViewController : UITableViewController {
    NSMutableArray *tableViewDataSource;
}

@property (nonatomic, strong) NSMutableArray *tableViewDataSource;
@property (nonatomic, assign) NSInteger page;

- (void)initTableViewDataSource;
- (void)addRefreshControlWithStartedBlock:(void (^)(void))block;
- (void)startRefreshControl;

@end
