//
//  ViewController.m
//  YPKit
//
//  Created by 喻平 on 2017/10/24.
//  Copyright © 2017年 YPKit. All rights reserved.
//

#import "ViewController.h"
#import "YPKit.h"
#import <objc/runtime.h>

@interface UIViewController (Add)

@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, strong) NSString *udString;
@property (nonatomic, strong) NSDictionary *udDict;
@property (nonatomic, strong) NSArray *udArray;

@end

@implementation UIViewController (Add)

YP_DYNAMIC_PROPERTY_COPY(string, setString, NSString *)
YP_DYNAMIC_PROPERTY_RETAIN(color, setColor, UIColor *)
YP_DYNAMIC_PROPERTY_CTYPE(count, setCount, NSInteger)
YP_DYNAMIC_PROPERTY_CTYPE(size, setSize, CGSize)


YP_USER_DEFAULTS_PROPERTY(udString, setUdString, @"udString")
YP_USER_DEFAULTS_PROPERTY(udDict, setUdDict, @"udDict")
YP_USER_DEFAULTS_PROPERTY(udArray, setUdArray, @"udArray")

@end


@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.string = @"asdfas";
    self.color = [UIColor lightGrayColor];
    self.count = 100;
    self.size = CGSizeMake(100, 20);
    
    
    self.udString = @"123231";
    self.udDict = @{@"asdf" : @"adsfs"};
    self.udArray = @[@"asdfads", @"adsfdass"];
    NSLog(@"string--->%@", self.udString);
    NSLog(@"color--->%@", self.udDict);
    NSLog(@"count--->%@", self.udArray);
    NSLog(@"size--->%@", NSStringFromCGSize(self.size));
    
    self.imageView.image = [UIImage imageWithContentsOfFileName:@"icon_pause"];
    UIColor *color1 = [UIColor colorWithHexString:@"abc"];
    UIColor *color2 = [UIColor colorWithHexString:@"aabbcc"];
    UIColor *color3 = [UIColor colorWithHexString:@"abcf"];
    UIColor *color4 = [UIColor colorWithHexString:@"aabbccff"];
    NSLog(@"\n%@\n%@\n%@\n%@", color1, color2, color3, color4);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    [UIAlertController showAlertWithTitle:@"adsf" message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"asdf", @"adsf"] completion:^(NSInteger buttonIndex) {
        NSLog(@"index-->%d", buttonIndex);
    }];
//    [UIAlertController showActionSheetWithTitle:@"adsf" message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"daf", @"asd"] inViewController:[UIApplication sharedApplication].delegate.window.rootViewController completion:^(NSInteger buttonIndex) {
//        NSLog(@"index-->%d", buttonIndex);
//    }];
}

@end

