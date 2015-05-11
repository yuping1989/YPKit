//
//  UITableView+YPGenaral.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (YPGenaral)
- (void)registerNibWithName:(NSString *)name;
- (void)reloadRow:(NSInteger)row inSection:(NSInteger)section;
- (void)reloadRow:(NSInteger)row;
- (void)deleteRow:(NSInteger )row;
- (void)setFooterText:(NSString *)text;
- (void)setFooterText:(NSString *)text
                 font:(UIFont *)font
                color:(UIColor *)color
               height:(int)height;
@end
