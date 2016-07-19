//
//  YPBaseSegmentedController.h
//  ChangQingQuan
//
//  Created by 喻平 on 15/4/17.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import "YPBaseViewController.h"

@interface YPBaseSegmentedController : YPBaseViewController

@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) UIViewController *selectedController;
@property (nonatomic, assign) CGRect contentViewFrame;

- (void)segmentedValueChanged:(UISegmentedControl *)segmentedControl;

@end
