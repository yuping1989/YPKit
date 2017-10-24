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

@interface CustomViewController () <UIAlertViewDelegate> {
    id observer1, observer2, observer3;
}
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
    
    [self.button addTouchUpInsideEventBlock:^(id  _Nonnull sender) {
        
    }];
    
    self.singleLabel.textColor = UIColorRGB(255, 0, 0);
    self.doubleLabel.textColor = UIColorRGBA(255, 0, 0, 0.2f);
}

- (void)dealloc {
    NSLog(@"asdf");
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
        self.checkBox.yp_width = 200;
    } else {
        self.checkBox.yp_width = 100;
    }
}

@end
