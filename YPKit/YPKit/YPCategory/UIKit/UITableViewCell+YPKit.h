//
//  UITableViewCell+YPKit.h
//  YPKit
//
//  Created by 喻平 on 16/7/1.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (YPKit)

/**
 *  设置UITableViewCell的内容
 */
- (void)configureCell:(id)obj;

/**
 *  通过设置可变部分的内容来确定UITableViewCell的高度，用于AutoLayout
 */
- (void)configureCellHeight:(id)obj;

@end

NS_ASSUME_NONNULL_END
