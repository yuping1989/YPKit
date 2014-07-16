//
//  BaseTableViewController.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-7-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController
{
    NSMutableArray *tableViewDataSource;
}
@property (nonatomic, strong) NSMutableArray *tableViewDataSource;
- (void)initTableViewDataSource;
- (void)addRefreshControl;
- (void)refreshControlStarted;
- (void)startRefreshControl;
@end
