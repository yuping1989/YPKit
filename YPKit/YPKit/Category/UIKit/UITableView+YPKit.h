//
//  UITableView+YPGenaral.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (YPKit)

- (void)registerNibWithName:(NSString *)name;

- (void)reloadRow:(NSInteger)row inSection:(NSInteger)section;
- (void)reloadRow:(NSInteger)row;
- (void)deleteRow:(NSInteger)row;

- (void)scrollToRow:(NSInteger)row animated:(BOOL)animated;
- (void)scrollToRow:(NSInteger)row inSection:(NSInteger)section animated:(BOOL)animated;

/**
 *  在UITableView的末尾显示一段文字
 */
- (void)setFooterText:(NSString *)text;
- (void)setFooterText:(NSString *)text
                 font:(nullable UIFont *)font
                color:(nullable UIColor *)color
               height:(NSInteger)height;

@end

NS_ASSUME_NONNULL_END
