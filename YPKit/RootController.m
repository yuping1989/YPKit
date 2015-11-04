//
//  RootController.m
//  YPKit
//
//  Created by 喻平 on 15/8/14.
//  Copyright (c) 2015年 YPKit. All rights reserved.
//

#import "RootController.h"
#import "YPTextViewController.h"
#import "YPDateUtilController.h"
#import "AutoLayoutCellController.h"

@interface RootController ()

@end

@implementation RootController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YPKit";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"YPTextView";
            break;
        case 1:
            cell.textLabel.text = @"YPDateUtil";
            break;
        case 2:
            cell.textLabel.text = @"AutoLayoutCell";
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[YPTextViewController instance] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[YPDateUtilController instance] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[AutoLayoutCellController instance] animated:YES];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
