//
//  YPTabBar.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPTabBar : UIScrollView
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIImage *itemNormalBgImage;
@property (nonatomic, strong) UIImage *itemSelectedBgImage;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) int spaceWidth;
@end
