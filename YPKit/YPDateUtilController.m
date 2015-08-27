//
//  YPDateUtilController.m
//  YPKit
//
//  Created by 喻平 on 15/8/20.
//  Copyright (c) 2015年 YPKit. All rights reserved.
//

#import "YPDateUtilController.h"

@interface YPDateUtilController ()
@property (nonatomic, weak) IBOutlet UILabel *secondLabel;
@property (nonatomic, weak) IBOutlet UILabel *minuteLabel;
@property (nonatomic, weak) IBOutlet UILabel *hourLabel;
@property (nonatomic, weak) IBOutlet UILabel *dayLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@end

@implementation YPDateUtilController

- (void)viewDidLoad {
    [super viewDidLoad];
    int date = [[NSDate date] timeIntervalSince1970];
    NSLog(@"second-->%@", NSStringFromCGRect(self.view.frame));
    _secondLabel.text = [[YPDateUtil shareInstance] dateDiffStringWithFromTimeInterval:date - 10];
    _minuteLabel.text = [[YPDateUtil shareInstance] dateDiffStringWithFromTimeInterval:date - 3 * 60];
    _hourLabel.text = [[YPDateUtil shareInstance] dateDiffStringWithFromTimeInterval:date - 60 * 60 * 3];
    _dayLabel.text = [[YPDateUtil shareInstance] dateDiffStringWithFromTimeInterval:date - 60 * 60 * 40];
    _dateLabel.text = [[YPDateUtil shareInstance] dateDiffStringWithFromTimeInterval:date - 60 * 60 * 24 * 3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
