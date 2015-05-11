//
//  YPTabBarController.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-5-15.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "YPTabBarController.h"
#import "YPTabItem.h"

#define kYpTabItemImage @"kYpTabItemImage"
#define kYpTabItemSelectedImage @"kYpTabItemSelectedImage"

@interface YPTabBarController () 
{
    BOOL _didViewAppeared;
}
@end

@implementation YPTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (CGRectEqualToRect(_tabBarFrame, CGRectZero)) {
        self.tabBarFrame = CGRectMake(0, self.view.height - 64 - 50, self.view.width, 50);
    }
    
    if (CGRectEqualToRect(_contentViewFrame, CGRectZero)) {
        self.contentViewFrame = CGRectMake(0, 0, self.view.width, _tabBarFrame.origin.y);
    }
    self.tabBar = [[YPTabBar alloc] initWithFrame:_tabBarFrame];
    _tabBar.delegate = self;
    [self.view addSubview:_tabBar];
    
    NSMutableArray *items = [NSMutableArray array];
    for (UIViewController *controller in _viewControllers) {
        YPTabItem *item = [YPTabItem instance];
        [item setImage:controller.ypTabItemImage forState:UIControlStateNormal];
        [item setImage:controller.ypTabItemSelectedImage forState:UIControlStateSelected];
        [item setTitle:controller.title forState:UIControlStateNormal];
        item.titleLabel.font = [UIFont systemFontOfSize:10];
        [items addObject:item];
    }
    
    _tabBar.items = items;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_didViewAppeared) {
        _tabBar.selectedItemIndex = 0;
        _didViewAppeared = YES;
    }
    
}
- (void)setViewControllers:(NSMutableArray *)viewControllers
{
    _viewControllers = viewControllers;
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addChildViewController:obj];
    }];
}
- (void)setSelectedController:(YPBaseViewController *)selectedController
{
    if (_selectedController) {
        if (_selectedController == selectedController) {
            return;
        }
        [_selectedController.view removeFromSuperview];
        _selectedController = nil;
    }
    _selectedController = selectedController;
    [self.view addSubview:_selectedController.view];
    if (!CGRectEqualToRect(_selectedController.view.frame, _contentViewFrame)) {
        _selectedController.view.frame = _contentViewFrame;
    }
}

- (void)YPTabBar:(YPTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"index-->%ld", index);
    if ([_viewControllers[index] isEqual:self.selectedController]) {
        NSLog(@"equal");
        return;
    }
    self.selectedController = _viewControllers[index];
    [_selectedController viewDidDisplayByTabSelected];
    for (YPTabItem *item in _tabBar.items) {
        if (index == item.index) {
            item.selected = YES;
        } else {
            if (item.selected) {
                item.selected = NO;
            }
        }
    }
}

- (void)replaceControllerAtIndex:(int)index withController:(UIViewController *)controller
{
    [self.viewControllers[index] removeFromParentViewController];
    [self.viewControllers replaceObjectAtIndex:index withObject:controller];
    [self addChildViewController:controller];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

@implementation UIViewController (TabController)

- (UIImage *)ypTabItemImage {
    return objc_getAssociatedObject(self, kYpTabItemImage);
}

- (void)setYpTabItemImage:(UIImage *)image {
    objc_setAssociatedObject(self, kYpTabItemImage, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)ypTabItemSelectedImage {
    return objc_getAssociatedObject(self, kYpTabItemSelectedImage);
}

- (void)setYpTabItemSelectedImage:(UIImage *)image {
    objc_setAssociatedObject(self, kYpTabItemSelectedImage, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (YPTabItem *)ypTabItem
{
    YPTabBar *tabBar = self.ypTabBarController.tabBar;
    NSInteger index = [self.ypTabBarController.viewControllers indexOfObject:self];
    return tabBar.items[index];
}

- (YPTabBarController *)ypTabBarController
{
    return (YPTabBarController *)self.parentViewController;
}
- (void)viewDidDisplayByTabSelected
{
    
}
@end


