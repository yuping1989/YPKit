//
//  CustomViewController.m
//  YPKit
//
//  Created by 喻平 on 16/6/3.
//  Copyright © 2016年 YPKit. All rights reserved.
//

#import "CustomViewController.h"
#import "YPCheckBox.h"
#import "YPImagePicker.h"

@interface CustomViewController () <UIAlertViewDelegate>
@property (nonatomic, weak) IBOutlet YPCheckBox *checkBox;
@property (nonatomic, weak) IBOutlet UISwitch *mSwitch;
@property (nonatomic, weak) IBOutlet UILabel *singleLabel;
@property (nonatomic, weak) IBOutlet UILabel *doubleLabel;
@property (nonatomic, weak) IBOutlet UIButton *button;
@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.checkBox setNormalImage:[UIImage imageNamed:@"checkbox_unchecked"] checkedImage:[UIImage imageNamed:@"checkbox_checked"]];
    [self.checkBox setStateChangedBlock:^(BOOL checked) {
        [YPCheckBox viewFromNib];
    }];
//    [self.button addTouchUpInsideTarget:self action:@selector(first)];
//    [self.button addTouchUpInsideTarget:self action:@selector(first)];
//    [self.button handleControlEvent:UIControlEventTouchUpInside
//                          withBlock:^(id sender) {
//                              NSLog(@"1");
//                          }];
//    [self.button handleControlEvent:UIControlEventTouchUpInside
//                          withBlock:^(id sender) {
//                              NSLog(@"2");
//                          }];

    [self.button setBlockForControlEvents:UIControlEventTouchUpInside
                                    block:^(id sender) {
                                        NSLog(@"4");
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"adsf"
                                                                                        message:nil
                                                                                       delegate:nil
                                                                              cancelButtonTitle:@"cancel"
                                                                              otherButtonTitles:@"first", @"second", nil];
                                        [alert showWithCompletionHandler:^(NSInteger buttonIndex) {
                                            NSLog(@"index--->%ld", (long)buttonIndex);
                                        }];
//                                        alert.delegate = self;
                                    }];
}

- (void)first {
    NSLog(@"first");
}

- (void)second {
    NSLog(@"second");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChanged:(UISwitch *)sender {
    NSLog(@"value changed--->");
    if (sender.on) {
        self.checkBox.width = 200;
    } else {
        self.checkBox.width = 100;
    }
}

@end
