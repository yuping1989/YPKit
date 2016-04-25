//
//  YPBaseTableViewController.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-7-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "YPBaseTableViewController.h"

@interface YPBaseTableViewController ()
@property (nonatomic, copy) YPCompletionBlock refreshStartedBlock;
@end

@implementation YPBaseTableViewController
@synthesize tableViewDataSource;
- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOS7_AND_LATER) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
#ifdef UDIsNightModel
    [self nightModelSwitched:nil];
#endif
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTableViewDataSource
{
    self.tableViewDataSource = [[NSMutableArray alloc] init];
}

- (void)addRefreshControlWithStartedHandler:(YPCompletionBlock)handler
{
    if (self.refreshControl == nil) {
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(refreshControlStarted) forControlEvents:UIControlEventValueChanged];
        self.refreshStartedBlock = handler;
    }
}
- (void)startRefreshControl
{
    [self.refreshControl beginRefreshing];
    [self refreshControlStarted];
}
- (void)refreshControlStarted
{
    if (_refreshStartedBlock) {
        _refreshStartedBlock();
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"table count-->%lu", tableViewDataSource.count);
    return [tableViewDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    return cell;
}

@end
