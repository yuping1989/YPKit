//
//  YPTableViewController.h
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-3-24.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPBaseViewController.h"
@interface YPTableViewController : YPBaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *tableViewDataSource;
}
@property (nonatomic, strong) NSMutableArray *tableViewDataSource;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
- (void)initTableViewDataSource;
@end
