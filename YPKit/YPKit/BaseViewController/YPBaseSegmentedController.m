//
//  YPBaseSegmentedController.m
//  ChangQingQuan
//
//  Created by 喻平 on 15/4/17.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import "YPBaseSegmentedController.h"

@interface YPBaseSegmentedController () {
    BOOL _viewWillAppearFirstTime;
}
@end

@implementation YPBaseSegmentedController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_segmentedControl addTarget:self action:@selector(segmentedValueChanged:) forControlEvents:UIControlEventValueChanged];
    _viewWillAppearFirstTime = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_viewWillAppearFirstTime) {
        self.segmentedControl.selectedSegmentIndex = 0;
        [self segmentedValueChanged:self.segmentedControl];
        _viewWillAppearFirstTime = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
    if (!CGRectEqualToRect(_selectedController.view.frame, _contentViewFrame)) {
        _selectedController.view.frame = _contentViewFrame;
    }
    [self.view addSubview:_selectedController.view];
}

- (void)segmentedValueChanged:(UISegmentedControl *)segmentedControl {
    if ([_viewControllers[segmentedControl.selectedSegmentIndex] isEqual:self.selectedController]) {
        NSLog(@"equal");
        return;
    }
    self.selectedController = _viewControllers[segmentedControl.selectedSegmentIndex];
}
@end
