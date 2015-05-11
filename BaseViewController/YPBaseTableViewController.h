//
//  YPBaseTableViewController.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-7-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPBaseTableViewController : UITableViewController
{
    NSMutableArray *tableViewDataSource;
    int _page;
}
@property (nonatomic, strong) NSMutableArray *tableViewDataSource;
- (void)initTableViewDataSource;
- (void)addRefreshControlWithStartedHandler:(CompletionBlock)handler;
- (void)startRefreshControl;
@end
