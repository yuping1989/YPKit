//
//  YPTextViewController.m
//  YPKit
//
//  Created by 喻平 on 15/8/14.
//  Copyright (c) 2015年 YPKit. All rights reserved.
//

#import "YPTextViewController.h"
#import "YPTextView.h"

@interface YPTextViewController ()<YPTextViewDelegate>
@property (nonatomic, weak) IBOutlet UIView *bgView;
@property (nonatomic, weak) IBOutlet YPTextView *textView1;
@end

@implementation YPTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _textView1.delegate = self;
    [self hideKeyboardWhenTapBackground];
//    NSLog(@"content size-->%@", NSStringFromCGSize(_textView1.contentSize));
//    NSLog(@"content offset--->%@", NSStringFromCGPoint(_textView1.contentOffset));
//    NSLog(@"container--->%@", NSStringFromUIEdgeInsets(_textView1.textContainerInset));
//    _textView1.maxHeight = 100;
    _textView1.textContainerInset = UIEdgeInsetsMake(5, 0, 5, 0);
//    _textView1.heigthChangedAnimateDuration = 0.25f;
    self.bgView.frame = CGRectMake(0, SCREEN_HEIGHT - 500 - 44, SCREEN_WIDTH, 44);
    NSLog(@"frame--->%@", NSStringFromCGRect(self.bgView.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textView:(YPTextView *)textView didContentHeightChanged:(CGFloat)height {
    NSLog(@"height--->%f", height);
    textView.height = height;
    self.bgView.frame = CGRectMake(0, SCREEN_HEIGHT - height - 14 - 500, SCREEN_WIDTH, height + 14);
    NSLog(@"frame--->%@", NSStringFromCGRect(self.bgView.frame));
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSLog(@"url--->%@", URL.absoluteString);
    return NO;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"text-->%@", textView.text);
}
@end
