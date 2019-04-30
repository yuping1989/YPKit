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

@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, assign) BOOL on;
@property (nonatomic, assign) float amount;
@property (nonatomic, assign) double price;


@end

@implementation UIViewController (Add)

YP_DYNAMIC_PROPERTY_COPY(string, setString, NSString *)
YP_DYNAMIC_PROPERTY_RETAIN(color, setColor, UIColor *)
YP_DYNAMIC_PROPERTY_CTYPE(count, setCount, NSInteger)
YP_DYNAMIC_PROPERTY_CTYPE(size, setSize, CGSize)


YP_USER_DEFAULTS_PROPERTY_OBJECT(udString, setUdString, @"udString")
YP_USER_DEFAULTS_PROPERTY_OBJECT(udDict, setUdDict, @"udDict")
YP_USER_DEFAULTS_PROPERTY_OBJECT(udArray, setUdArray, @"udArray")

YP_USER_DEFAULTS_PROPERTY_INTEGER(weight, setWeight, @"udWeight")
YP_USER_DEFAULTS_PROPERTY_BOOL(on, setOn, @"udOn")
YP_USER_DEFAULTS_PROPERTY_FLOAT(amount, setAmount, @"udAmount")
YP_USER_DEFAULTS_PROPERTY_DOUBLE(price, setPrice, @"udPrice")

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
    
    self.weight = 10;
    self.on = YES;
    self.amount = 15.5f;
    self.price = 8.6f;
    
    NSLog(@"ud-->%zd %d %f %f", self.weight, self.on, self.amount, self.price);
    
    
    NSLog(@"first letter-->%@", [@"曾" pinyinFirstLetter]);
    NSLog(@"first letter-->%@", [@"仇钱" pinyinFirstLetterForName]);
    
    
    [self setKeyboardShowBlock:^(NSNotification * _Nonnull noti, CGRect rect, CGFloat duration) {
        NSLog(@"show-->%@", NSStringFromCGRect(rect));
    } hideBlock:^(NSNotification * _Nonnull noti, CGRect rect, CGFloat duration) {
        NSLog(@"hide-->%@", NSStringFromCGRect(rect));
    }];
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

