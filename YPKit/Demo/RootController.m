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
#import "WebViewController.h"
#import "TestHttpUtil.h"
#import "CustomViewController.h"

@interface RootController ()
@property (nonatomic, strong) void (^block)();



@end

@implementation RootController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YPKit";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    NSString *email = @"\n0.3 d  ";
    
    NSLog(@"is email-->%f", [email numberValue].floatValue);
    
    
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
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"YPTestTextView";
            break;
        case 1:
            cell.textLabel.text = @"YPDateUtil";
            break;
        case 2:
            cell.textLabel.text = @"AutoLayoutCell";
            break;
        case 3:
            cell.textLabel.text = @"WebView";
            break;
        case 4:
            cell.textLabel.text = @"自定义View";
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"asdfasdfasdf" object:nil];
            [self.navigationController pushViewController:[YPTextViewController viewControllerFromNib] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[YPDateUtilController viewControllerFromNib] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[AutoLayoutCellController viewControllerFromNib] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[WebViewController viewControllerFromNib] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[CustomViewController viewControllerFromNib] animated:YES];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
