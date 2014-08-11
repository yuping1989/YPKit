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

- (void)reloadRow:(NSInteger)row
{
    [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)setFooterText:(NSString *)text
{
    [self setFooterText:text
                   font:[UIFont systemFontOfSize:17]
                  color:[UIColor lightGrayColor]
                 height:60];
}
- (void)setFooterText:(NSString *)text
                 font:(UIFont *)font
                color:(UIColor *)color
               height:(int)height
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, height)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = font;
    label.textColor = color;
    label.text = text;
    self.tableFooterView = label;
}
@end
