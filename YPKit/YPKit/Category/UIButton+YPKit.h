//
//  UIButton+YPKit.h
//  PiFuKeYiSheng
//
//  Created by yuping on 14-6-4.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YPKit)
@property (nonatomic, strong) NSIndexPath *indexPath;
- (void)centerImageAndTitle:(float)spacing;
@end
