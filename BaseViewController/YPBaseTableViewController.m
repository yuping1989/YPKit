//
//  YPBaseTableViewController.m
//  HuoQiuJiZhang-buyer
//
//  Created by 喻平 on 14-3-24.
//  Copyright (c) 2014年 com.huoqiu. All rights reserved.
//

#import "YPBaseTableViewController.h"

@interface YPBaseTableViewController ()

@end

@implementation YPBaseTableViewController
@synthesize tableViewDataSource;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)initTableViewDataSource
{
    self.tableViewDataSource = [[NSMutableArray alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"table count-->%d", tableViewDataSource.count);
    return [tableViewDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    return cell;
}


@end
