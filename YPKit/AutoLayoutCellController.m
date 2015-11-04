//
//  AutoLayoutCellController.m
//  YPKit
//
//  Created by 喻平 on 15/10/23.
//  Copyright © 2015年 YPKit. All rights reserved.
//

#import "AutoLayoutCellController.h"
#import "AutoLayoutCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface AutoLayoutCellController ()
{
    AutoLayoutCell *_cell;
}
@end

@implementation AutoLayoutCellController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    [self.tableView registerNibWithName:@"AutoLayoutCell"];
    [self initTableViewDataSource];
    [tableViewDataSource addObject:@{@"text" : @"啊十分的咖啡拉升了亏大发了快递费拉卡拉亏大发的算法第三方"}];
    [tableViewDataSource addObject:@{@"text" : @"啊十分的咖啡拉升了亏大发了快递费拉卡拉亏大发的算法第三方萨法撒打发打算阿萨德发的发阿打算发撒算法的阿萨德飞 阿斯顿发大水阿萨德发生的发生"}];
    [tableViewDataSource addObject:@{@"text" : @"啊十分的咖啡拉升了亏大发了快递费拉卡拉亏大发的算法第三方啊十分的咖啡拉升了亏大发了快递费拉卡拉亏大发的算法第三方萨法撒打发打算阿萨德发的发阿打算发撒算法的阿萨德飞 阿斯顿发大水阿萨德发生的发生啊十分的咖啡拉升了亏大发了快递费拉卡拉亏大发的算法第三方萨法撒打发打算阿萨德发的发阿打算发撒算法的阿萨德飞 阿斯顿发大水阿萨德发生的发生"}];
    [tableViewDataSource addObject:@{@"text" : @"啊十分的咖啡拉升了亏大发了快递费拉卡拉亏大发的算法第三方"}];
    _cell = [[[NSBundle mainBundle] loadNibNamed:@"AutoLayoutCell" owner:self options:nil] firstObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AutoLayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AutoLayoutCell" forIndexPath:indexPath];
    NSDictionary *dict = tableViewDataSource[indexPath.row];
    cell.titleLabel.text = dict[@"text"];
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
//    
//    [_cell.contentView setNeedsLayout];
//    [_cell.contentView layoutIfNeeded];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = tableViewDataSource[indexPath.row];
//    _cell.titleLabel.text = dict[@"text"];
//    CGSize size = [_cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    NSLog(@"h=%f", size.height + 1);
    
    return [tableView fd_heightForCellWithIdentifier:@"AutoLayoutCell"
                                    cacheByIndexPath:indexPath
                                       configuration:^(AutoLayoutCell *cell) {
                                           cell.titleLabel.text = dict[@"text"];
                                       }];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[AutoLayoutCellController instance] animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
