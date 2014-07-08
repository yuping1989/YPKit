//
//  UITableView+YPGenaral.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "UITableView+YPGenaral.h"

@implementation UITableView (YPGenaral)
- (void)registerNibName:(NSString *)name
{
    [self registerNib:[UINib nibWithNibName:name bundle:nil] forCellReuseIdentifier:name];
}

- (void)reloadRow:(NSInteger)row inSection:(NSInteger)section
{
    [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:section]] withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end
