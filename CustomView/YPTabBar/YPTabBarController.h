//
//  YPTabBarController.h
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "YPBaseViewController.h"
#import "YPTabBar.h"
#import "YPTabItem.h"
@interface YPTabBarController : YPBaseViewController <YPTabBarDelegate>
{

}
@property (nonatomic, strong) YPTabBar *tabBar;

@property (nonatomic, assign) CGRect tabBarFrame;
@property (nonatomic, assign) CGRect contentViewFrame;
@property (nonatomic, strong) UIViewController *selectedController;
@property (nonatomic, strong) NSMutableArray *viewControllers;
- (void)replaceControllerAtIndex:(int)index withController:(UIViewController *)controller;
@end

@interface UIViewController (TabController)
- (void)viewDidDisplayByTabSelected;

- (UIImage *)ypTabItemImage;
- (void)setYpTabItemImage:(UIImage *)image;

- (UIImage *)ypTabItemSelectedImage;
- (void)setYpTabItemSelectedImage:(UIImage *)image;

- (YPTabItem *)ypTabItem;
- (YPTabBarController *)ypTabBarController;
@end


